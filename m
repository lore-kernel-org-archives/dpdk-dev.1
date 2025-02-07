Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE0AC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:46:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F9DC42E9C;
	Fri,  7 Feb 2025 16:46:06 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 35EC242DDC
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:46:04 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3F8332109CE9; Fri,  7 Feb 2025 07:46:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F8332109CE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738943163;
 bh=jZgj2XlDPWJXoDDJGz+csPsDIERmu0kcmQq24KcAA3c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ONWBAtnBw7X0uAz/p3AlbFy1QAqveO3Aisc3Jn53PCVqAIr83hbtY7wruLsDNJ8XJ
 aQsnBLbIe18fOf6bOtneqiifmqcQ0psl9vLhFe3S9vTWqs4tycE+Z1tjvCmHe5WeWN
 c6n7uRZNxZnAOpPs+HiNF1xNLqIUzW4YVRxol/LA=
Date: Fri, 7 Feb 2025 07:46:03 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: anatoly.burakov@intel.com, dev@dpdk.org, ian.stokes@intel.com,
 jochen.behrens@broadcom.com, vladimir.medvedkin@intel.com,
 stephen@networkplumber.org
Subject: Re: [PATCH v4] drivers/net: use 64-bit shift and avoid
 signed/unsigned mismatch
Message-ID: <20250207154603.GB21754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738783944-10172-1-git-send-email-andremue@linux.microsoft.com>
 <Z6SX9MGQC3f776nN@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6SX9MGQC3f776nN@bricha3-mobl1.ger.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Thu, Feb 06, 2025 at 11:07:32AM +0000, Bruce Richardson wrote:
> On Wed, Feb 05, 2025 at 11:32:24AM -0800, Andre Muezerie wrote:
> > This patch avoids warnings like the ones below emitted by MSVC:
> > 
> > 1)
> > ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
> >     result of 32-bit shift implicitly converted to 64 bits
> >     (was 64-bit shift intended?)
> > 
> > 2)
> > ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
> >     signed/unsigned mismatch
> > 
> > The fix for (1) is to use 64-bit shifting when appropriate
> > (according to what the result is used for).
> > 
> > The fix for (2) is to explicitly cast the variables used in the
> > comparison.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
> >  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
> >  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
> >  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
> >  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
> >  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
> >  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
> >  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
> >  drivers/net/vmxnet3/vmxnet3_ethdev.h   |  6 +++---
> >  10 files changed, 35 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> > index bf5560ccc8..7a962c239d 100644
> > --- a/drivers/net/intel/i40e/i40e_ethdev.c
> > +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> > @@ -3094,7 +3094,7 @@ i40e_stat_update_48_in_64(struct i40e_hw *hw, uint32_t hireg,
> >  	/* enlarge the limitation when statistics counters overflowed */
> >  	if (offset_loaded) {
> >  		if (I40E_RXTX_BYTES_L_48_BIT(*prev_stat) > *stat)
> > -			*stat += (uint64_t)1 << I40E_48_BIT_WIDTH;
> > +			*stat += RTE_BIT64(I40E_48_BIT_WIDTH);
> >  		*stat += I40E_RXTX_BYTES_H_16_BIT(*prev_stat);
> >  	}
> >  	*prev_stat = *stat;
> > @@ -4494,7 +4494,7 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
> >  	pool_sel = dev->data->mac_pool_sel[index];
> >  
> >  	for (i = 0; i < sizeof(pool_sel) * CHAR_BIT; i++) {
> > -		if (pool_sel & (1ULL << i)) {
> > +		if (pool_sel & RTE_BIT64(i)) {
> >  			if (i == 0)
> >  				vsi = pf->main_vsi;
> >  			else {
> > @@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
> >  	for (i = 0; i < reta_size; i++) {
> >  		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> >  		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> > -		if (reta_conf[idx].mask & (1ULL << shift))
> > +		if (reta_conf[idx].mask & RTE_BIT64(shift))
> >  			lut[i] = reta_conf[idx].reta[shift];
> >  	}
> >  	ret = i40e_set_rss_lut(pf->main_vsi, lut, reta_size);
> > @@ -4674,7 +4674,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
> >  	for (i = 0; i < reta_size; i++) {
> >  		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> >  		shift = i % RTE_ETH_RETA_GROUP_SIZE;
> > -		if (reta_conf[idx].mask & (1ULL << shift))
> > +		if (reta_conf[idx].mask & RTE_BIT64(shift))
> >  			reta_conf[idx].reta[shift] = lut[i];
> >  	}
> >  
> > @@ -6712,7 +6712,7 @@ i40e_vmdq_setup(struct rte_eth_dev *dev)
> >  	loop = sizeof(vmdq_conf->pool_map[0].pools) * CHAR_BIT;
> >  	for (i = 0; i < vmdq_conf->nb_pool_maps; i++) {
> >  		for (j = 0; j < loop && j < pf->nb_cfg_vmdq_vsi; j++) {
> > -			if (vmdq_conf->pool_map[i].pools & (1UL << j)) {
> > +			if (vmdq_conf->pool_map[i].pools & RTE_BIT64(j)) {
> >  				PMD_INIT_LOG(INFO, "Add vlan %u to vmdq pool %u",
> >  					vmdq_conf->pool_map[i].vlan_id, j);
> >  
> > @@ -6761,7 +6761,7 @@ i40e_stat_update_32(struct i40e_hw *hw,
> >  		*stat = (uint64_t)(new_data - *offset);
> >  	else
> >  		*stat = (uint64_t)((new_data +
> > -			((uint64_t)1 << I40E_32_BIT_WIDTH)) - *offset);
> > +			RTE_BIT64(I40E_32_BIT_WIDTH)) - *offset);
> >  }
> >  
> >  static void
> > @@ -6789,7 +6789,7 @@ i40e_stat_update_48(struct i40e_hw *hw,
> >  		*stat = new_data - *offset;
> >  	else
> >  		*stat = (uint64_t)((new_data +
> > -			((uint64_t)1 << I40E_48_BIT_WIDTH)) - *offset);
> > +			RTE_BIT64(I40E_48_BIT_WIDTH)) - *offset);
> >  
> >  	*stat &= I40E_48_BIT_MASK;
> >  }
> > @@ -7730,7 +7730,7 @@ i40e_config_hena(const struct i40e_adapter *adapter, uint64_t flags)
> >  		return hena;
> >  
> >  	for (i = RTE_ETH_FLOW_UNKNOWN + 1; i < I40E_FLOW_TYPE_MAX; i++) {
> > -		if (flags & (1ULL << i))
> > +		if (flags & RTE_BIT64(i))
> >  			hena |= adapter->pctypes_tbl[i];
> >  	}
> >  
> > @@ -7749,7 +7749,7 @@ i40e_parse_hena(const struct i40e_adapter *adapter, uint64_t flags)
> >  
> >  	for (i = RTE_ETH_FLOW_UNKNOWN + 1; i < I40E_FLOW_TYPE_MAX; i++) {
> >  		if (flags & adapter->pctypes_tbl[i])
> > -			rss_hf |= (1ULL << i);
> > +			rss_hf |= RTE_BIT64(i);
> >  	}
> >  	return rss_hf;
> >  }
> > @@ -10162,7 +10162,7 @@ i40e_flowtype_to_pctype(const struct i40e_adapter *adapter, uint16_t flow_type)
> >  	if (flow_type < I40E_FLOW_TYPE_MAX) {
> >  		pctype_mask = adapter->pctypes_tbl[flow_type];
> >  		for (i = I40E_FILTER_PCTYPE_MAX - 1; i > 0; i--) {
> > -			if (pctype_mask & (1ULL << i))
> > +			if (pctype_mask & RTE_BIT64(i))
> >  				return (enum i40e_filter_pctype)i;
> >  		}
> >  	}
> > @@ -10174,7 +10174,7 @@ i40e_pctype_to_flowtype(const struct i40e_adapter *adapter,
> >  			enum i40e_filter_pctype pctype)
> >  {
> >  	uint16_t flowtype;
> > -	uint64_t pctype_mask = 1ULL << pctype;
> > +	uint64_t pctype_mask = RTE_BIT64(pctype);
> >  
> >  	for (flowtype = RTE_ETH_FLOW_UNKNOWN + 1; flowtype < I40E_FLOW_TYPE_MAX;
> >  	     flowtype++) {
> > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> > index 328c224c93..9cd2b0c867 100644
> > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > @@ -2485,7 +2485,7 @@ iavf_init_proto_xtr(struct rte_eth_dev *dev)
> >  		if (!xtr_ol->required)
> >  			continue;
> >  
> > -		if (!(vf->supported_rxdid & BIT(rxdid))) {
> > +		if (!(vf->supported_rxdid & RTE_BIT64(rxdid))) {
> >  			PMD_DRV_LOG(ERR,
> >  				    "rxdid[%u] is not supported in hardware",
> >  				    rxdid);
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> > index c48c98e5e6..657963750d 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > @@ -3871,7 +3871,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
> >  			PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d] is legacy, "
> >  				"set rx_pkt_burst as legacy for all queues", rxq->rxdid, i);
> >  			use_flex = false;
> > -		} else if (!(vf->supported_rxdid & BIT(rxq->rxdid))) {
> > +		} else if (!(vf->supported_rxdid & RTE_BIT64(rxq->rxdid))) {
> >  			PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d] is not supported, "
> >  				"set rx_pkt_burst as legacy for all queues", rxq->rxdid, i);
> >  			use_flex = false;
> > diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> > index c74466735d..6feca8435e 100644
> > --- a/drivers/net/intel/iavf/iavf_vchnl.c
> > +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> > @@ -1263,7 +1263,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
> >  #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
> >  		if (vf->vf_res->vf_cap_flags &
> >  		    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
> > -			if (vf->supported_rxdid & BIT(rxq[i]->rxdid)) {
> > +			if (vf->supported_rxdid & RTE_BIT64(rxq[i]->rxdid)) {
> >  				vc_qp->rxq.rxdid = rxq[i]->rxdid;
> >  				PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d]",
> >  					    vc_qp->rxq.rxdid, i);
> > diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
> > index addb922ac9..dc5956f92c 100644
> > --- a/drivers/net/intel/ice/base/meson.build
> > +++ b/drivers/net/intel/ice/base/meson.build
> > @@ -31,18 +31,25 @@ sources = [
> >          'ice_vf_mbx.c',
> >  ]
> >  
> > -error_cflags = [
> > -        '-Wno-unused-but-set-variable',
> > -        '-Wno-unused-variable',
> > -        '-Wno-unused-parameter',
> > -]
> > +if is_ms_compiler
> > +    error_cflags = [
> > +            '/wd4101', # unreferenced local variable
> > +            '/wd4334', # result of 32-bit shift implicitly converted to 64 bits
> > +    ]
> > +else
> > +    error_cflags = [
> > +            '-Wno-unused-but-set-variable',
> > +            '-Wno-unused-variable',
> > +            '-Wno-unused-parameter',
> > +    ]
> > +endif
> >  
> 
> Do we actually need these if-else blocks here? The way
> the code is structured is that we check if the flags work to the current
> compiler and use only those that are relevant. Therefore, we should just be
> able to have a list of error flags and leave meson to filter out the
> incorrect ones.

Both approaches work. I personally find the if-else approach in this case a little more readable
as it makes clear to which compiler the flags apply (considering that there might be multiple
flags with the same purpose, one for each compiler). But I'm open to updating the patch following
your suggestion.

> 
> >  # Bugzilla ID: 678
> >  if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
> >      error_cflags += ['-Wno-array-bounds']
> >  endif
> >  
> > -if is_windows and cc.get_id() != 'clang'
> > +if is_windows and not is_ms_compiler and cc.get_id() != 'clang'
> 
> Are there other supported compiler options for windows other than MSVC and
> clang? For what compiler are we adding this flag?

Yes, MinGW-w64 is also supported on Windows, so effectively this flag applies to this compiler.
https://doc.dpdk.org/guides/windows_gsg/build_dpdk.html
Note that this flag was already there. I just changed the expression so that it is not used with msvc.

> 
> >      cflags += ['-fno-asynchronous-unwind-tables']
> >  endif
> >  
> > diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
> > index 7967c35533..2832d223d1 100644
> > --- a/drivers/net/intel/ice/ice_dcf_sched.c
> > +++ b/drivers/net/intel/ice/ice_dcf_sched.c
> > @@ -174,7 +174,7 @@ ice_dcf_node_param_check(struct ice_dcf_hw *hw, uint32_t node_id,
> >  	}
> >  
> >  	/* for non-leaf node */
> > -	if (node_id >= 8 * hw->num_vfs) {
> > +	if (node_id >= (uint32_t)(8 * hw->num_vfs)) {
> >  		if (params->nonleaf.wfq_weight_mode) {
> >  			error->type =
> >  				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> > index 80eee03204..6f6f618a2f 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -2469,13 +2469,13 @@ ice_get_supported_rxdid(struct ice_hw *hw)
> >  	uint32_t regval;
> >  	int i;
> >  
> > -	supported_rxdid |= BIT(ICE_RXDID_LEGACY_1);
> > +	supported_rxdid |= RTE_BIT64(ICE_RXDID_LEGACY_1);
> >  
> >  	for (i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
> >  		regval = ICE_READ_REG(hw, GLFLXP_RXDID_FLAGS(i, 0));
> >  		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
> >  			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
> > -			supported_rxdid |= BIT(i);
> > +			supported_rxdid |= RTE_BIT64(i);
> >  	}
> >  	return supported_rxdid;
> >  }
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> > index 8dd8644b16..87a9d93e89 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -399,7 +399,7 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
> >  	PMD_DRV_LOG(DEBUG, "Port (%u) - Rx queue (%u) is set with RXDID : %u",
> >  		    rxq->port_id, rxq->queue_id, rxdid);
> >  
> > -	if (!(pf->supported_rxdid & BIT(rxdid))) {
> > +	if (!(pf->supported_rxdid & RTE_BIT64(rxdid))) {
> >  		PMD_DRV_LOG(ERR, "currently package doesn't support RXDID (%u)",
> >  			    rxdid);
> >  		return -EINVAL;
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > index 5f18fbaad5..078f7b47c3 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> > @@ -2722,7 +2722,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
> >  					ixgbe_set_vf_rate_limit(
> >  						dev, vf,
> >  						vfinfo[vf].tx_rate[idx],
> > -						1 << idx);
> > +						RTE_BIT64(idx));
> >  	}
> >  
> >  	ixgbe_restore_statistics_mapping(dev);
> > diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.h b/drivers/net/vmxnet3/vmxnet3_ethdev.h
> > index e9ded6663d..e59cb285f4 100644
> > --- a/drivers/net/vmxnet3/vmxnet3_ethdev.h
> > +++ b/drivers/net/vmxnet3/vmxnet3_ethdev.h
> > @@ -186,14 +186,14 @@ static inline uint8_t
> >  vmxnet3_get_ring_idx(struct vmxnet3_hw *hw, uint32 rqID)
> >  {
> >  	return (rqID >= hw->num_rx_queues &&
> > -		rqID < 2 * hw->num_rx_queues) ? 1 : 0;
> > +		rqID < (uint32)2 * hw->num_rx_queues) ? 1 : 0;
> 
> Why uint32 rather than uint32_t which are the normal types we use in DPDK?
> Could this also be simplified to just 2U?

Well, I had just used the same type used for rqID (a few lines above).
BTW, there are more than 100 hits in DPDK when searching for "uint32 ".
I'm happy to use 2U instead though.

> 
> >  }
> >  
> >  static inline bool
> >  vmxnet3_rx_data_ring(struct vmxnet3_hw *hw, uint32 rqID)
> >  {
> > -	return (rqID >= 2 * hw->num_rx_queues &&
> > -		rqID < 3 * hw->num_rx_queues);
> > +	return (rqID >= (uint32)2 * hw->num_rx_queues &&
> > +		rqID < (uint32)3 * hw->num_rx_queues);
> >  }
> >  
> >  /*
> > -- 
> > 2.47.2.vfs.0.1
> > 
