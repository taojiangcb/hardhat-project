import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

const RccTokenModule = buildModule('RccTokenModule', (m) => {
    const rccToken = m.contract('RccToken', []);
    return { rccToken };
});

export default RccTokenModule;