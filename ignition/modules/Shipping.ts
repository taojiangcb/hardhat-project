// const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
// module.exports = buildModule("ShippingModule", (m) => {
//     const shipping = m.contract("Shipping", []);
//     m.call(shipping, "Status", []);
//     return { shipping };
// }); 

import {buildModule} from '@nomicfoundation/hardhat-ignition/modules';

const ShippingModule = buildModule("ShippingModule", (m) => {
    const shipping = m.contract("Shipping", []);
    m.call(shipping, "Status", []);
    return { shipping };
});

export default ShippingModule;