Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE0CD5BD2
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 07:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D25940264;
	Fri, 29 May 2026 09:29:27 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 3B616400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 09:29:23 +0200 (CEST)
X-QQ-mid: Yeas6t1780039757t006t20645
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [183.156.95.204])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 325932319137390679
To: "'Stephen Hemminger'" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>
References: <20260528213816.562910-1-stephen@networkplumber.org>
 <20260528213816.562910-9-stephen@networkplumber.org>
In-Reply-To: <20260528213816.562910-9-stephen@networkplumber.org>
Subject: RE: [RFC 8/8] net/txgbe: privatize legacy flow director types
Date: Fri, 29 May 2026 15:29:15 +0800
Message-ID: <07c201dcef3c$dab03710$9010a530$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIdwdgxGYOROzJOcYr1ofWus3K+4wKGuyYEtY6/4TA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MQ+wLuVvI2LQqeApCf3Wf+yc9IgnQkC3zVGJnxkhbDWz0X1P+MnuXOpg
 G2ZZZjuP4gMAJnIPbxxLyKVnOa1RbNn8niBZkLB60vaIZGLI3iTHuxmWEmVlFPZjSCRL6TL
 Vh4kNMs/iOFoVYCIsAD0raLoJI75pXPHOQycdk/1J63jXrP8Ino85wqVtajnWwNeBjwdKaG
 V0I3Jt6DO+KI0Mhcxnwd52hEBW+0TVRDiN1sc16ZJfmSPjhW7Ai0Hlm/cbIHiPx4dbFFULa
 Ol4yCAPZDL6/Enu9g4bE3SRrnAs1rfxb1HgNKSDk477OadyuNS4zcA6HS1dgzvr6RQ5PRac
 CWJCeyiRbShSmZiQAty1m5uuLHepgKTP5k4voPVsDRN1MLdLO1krAZ9tHguaNyQSDoFsYGI
 q25v2YsbXWURYh0QUIhFkQyF3YiwTxXmCMuJspZ/+7XntYhd/4lfQMDRbmgBf60NK/TGq2B
 w42m667PEddBS12/nVLded0rV0w1OcuoykOGpVHxOjISdl6cK4l4lDqJ5ytykN9o8axkpc6
 IQP84yoR95WBaWt4OwhnA2f1A3uUAf62iASgQVgaOo6t/mF+vM6rIzjnHX92Gcfar2Zp5aC
 ybUARidcT0uHpig/+7XqUwFIqoPfPdtvfonzCM9kLPZqdzAvNoaN3Eu5/2R+9CkZ9t15z8k
 fqYEO0/U6PIw34OS9UvSuX9Am/PJ6jMUE3gE0/iIcRdfxJgMyj/ZaDKiF0ERxd/OFUA8HdI
 kbxKWOG8eZzB7X+1HvapdGAx6KHmhmS9fs1h6c8Jx/Zd3Guc0jxFtn790bJb9H484dXCon1
 yvYFa+LvxOCHtBtrI+DtxCDCEU8/fZ2KzWVCxcbHhYR2Y/2Ebwv1pH5poBXPe/pA3tOx7J8
 aHs8qfe0k+88MwDL7Ynnl/YZ53bLPV3JxJ9gKpTezWbXJc7ClJPhdHqkkTxx4381dvycxPA
 VHDb/bVByqBKmCXiMvsvZakEwgvdzswoUoBobGgsPw7yUqX0X0ke6pwrd/CL/j0Fs6BWY2Q
 Qn6VszGxauMYUhojbBjIUBSaSyInHUwATFHw99jA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, May 29, 2026 5:37 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Jiawen Wu <jiawenwu@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>
> Subject: [RFC 8/8] net/txgbe: privatize legacy flow director types
> 
> The txgbe driver inherited its flow director representation from
> ixgbe (it derives from the same hardware lineage) and uses the
> same legacy ethdev types (struct rte_eth_fdir_conf, enum
> rte_fdir_mode, and related) as its internal IR for translating
> rte_flow rules into hardware programming state. These types are
> scheduled for removal from ethdev in DPDK 26.11.
> 
> Clone the relevant types into txgbe_ethdev.h with a txgbe-private
> prefix so the driver no longer depends on the legacy ABI. The
> embedded rte_eth_ipv4_flow / rte_eth_ipv6_flow types are cloned
> too since they live in the same removal candidate set.
> 
> Unlike ixgbe, txgbe base/ does not pre-declare an
> enum txgbe_fdir_pballoc_type, so the cloned one is defined here.
> txgbe uses the integer value of pballoc directly in the table-
> size calculation
> 
>     (1024 << (fdir_conf->pballoc + 1)) - 2
> 
> so the enum values match the original ethdev numbering
> (64K=0, 128K=1, 256K=2). pballoc is set explicitly from devargs
> in txgbe_handle_devarg(), so no extra initialization is required.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/txgbe/txgbe_ethdev.c          |   6 +-
>  drivers/net/txgbe/txgbe_ethdev.h          | 101 +++++++++++++++++++++-
>  drivers/net/txgbe/txgbe_fdir.c            |  78 ++++++++---------
>  drivers/net/txgbe/txgbe_flow.c            |  24 ++---
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   4 +-
>  5 files changed, 155 insertions(+), 58 deletions(-)

LGTM, thanks.

> diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
> index 5d360f8305..258ec4d97c 100644
> --- a/drivers/net/txgbe/txgbe_ethdev.c
> +++ b/drivers/net/txgbe/txgbe_ethdev.c
> @@ -524,7 +524,7 @@ txgbe_handle_devarg(__rte_unused const char *key, const char *value,
>  static void
>  txgbe_parse_devargs(struct rte_eth_dev *dev)
>  {
> -	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
> +	struct txgbe_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
>  	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
>  	struct rte_devargs *devargs = pci_dev->device.devargs;
>  	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
> @@ -934,7 +934,7 @@ static int txgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev)
> 
>  int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
>  {
> -	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(eth_dev);
> +	struct txgbe_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(eth_dev);
>  	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(eth_dev);
>  	char fdir_hash_name[RTE_HASH_NAMESIZE];
>  	u16 max_fdir_num = (1024 << (fdir_conf->pballoc + 1)) - 2;
> @@ -1834,7 +1834,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
>  	txgbe_configure_port(dev);
>  	txgbe_configure_dcb(dev);
> 
> -	if (TXGBE_DEV_FDIR_CONF(dev)->mode != RTE_FDIR_MODE_NONE) {
> +	if (TXGBE_DEV_FDIR_CONF(dev)->mode != TXGBE_FDIR_MODE_NONE) {
>  		err = txgbe_fdir_configure(dev);
>  		if (err)
>  			goto error;
> diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
> index 189fbac541..1f4ce4f3b8 100644
> --- a/drivers/net/txgbe/txgbe_ethdev.h
> +++ b/drivers/net/txgbe/txgbe_ethdev.h
> @@ -83,6 +83,103 @@
>  /*
>   * Information about the fdir mode.
>   */
> +/*
> + * Privatized flow director configuration types.
> + *
> + * Cloned from <rte_eth_ctrl.h> and <ethdev_driver.h> so that txgbe no
> + * longer depends on the legacy ethdev flow director ABI, which is
> + * scheduled for removal in DPDK 26.11. Semantics unchanged; only the
> + * names are txgbe-private.
> + *
> + * NB: txgbe uses the integer value of pballoc directly in
> + *     (1024 << (fdir_conf->pballoc + 1)) - 2
> + * to size the HW filter table. The enum values therefore match the
> + * original ethdev numbering (64K=0, 128K=1, 256K=2).
> + */
> +#define TXGBE_FDIR_MAX_FLEXLEN 16  /**< Max length of flexbytes. */
> +
> +struct txgbe_ipv4_flow {
> +	uint32_t src_ip;
> +	uint32_t dst_ip;
> +	uint8_t  tos;
> +	uint8_t  ttl;
> +	uint8_t  proto;
> +};
> +
> +struct txgbe_ipv6_flow {
> +	uint32_t src_ip[4];
> +	uint32_t dst_ip[4];
> +	uint8_t  tc;
> +	uint8_t  proto;
> +	uint8_t  hop_limits;
> +};
> +
> +struct txgbe_fdir_masks {
> +	uint16_t vlan_tci_mask;
> +	struct txgbe_ipv4_flow ipv4_mask;
> +	struct txgbe_ipv6_flow ipv6_mask;
> +	uint16_t src_port_mask;
> +	uint16_t dst_port_mask;
> +	uint8_t  mac_addr_byte_mask;
> +	uint32_t tunnel_id_mask;
> +	uint8_t  tunnel_type_mask;
> +};
> +
> +enum txgbe_payload_type {
> +	TXGBE_PAYLOAD_UNKNOWN = 0,
> +	TXGBE_RAW_PAYLOAD,
> +	TXGBE_L2_PAYLOAD,
> +	TXGBE_L3_PAYLOAD,
> +	TXGBE_L4_PAYLOAD,
> +	TXGBE_PAYLOAD_MAX = 8,
> +};
> +
> +struct txgbe_flex_payload_cfg {
> +	enum txgbe_payload_type type;
> +	uint16_t src_offset[TXGBE_FDIR_MAX_FLEXLEN];
> +};
> +
> +struct txgbe_fdir_flex_mask {
> +	uint16_t flow_type;
> +	uint8_t  mask[TXGBE_FDIR_MAX_FLEXLEN];
> +};
> +
> +struct txgbe_fdir_flex_conf {
> +	uint16_t nb_payloads;
> +	uint16_t nb_flexmasks;
> +	struct txgbe_flex_payload_cfg flex_set[TXGBE_PAYLOAD_MAX];
> +	struct txgbe_fdir_flex_mask flex_mask[RTE_ETH_FLOW_MAX];
> +};
> +
> +enum txgbe_fdir_mode {
> +	TXGBE_FDIR_MODE_NONE = 0,
> +	TXGBE_FDIR_MODE_SIGNATURE,
> +	TXGBE_FDIR_MODE_PERFECT,
> +	TXGBE_FDIR_MODE_PERFECT_MAC_VLAN,
> +	TXGBE_FDIR_MODE_PERFECT_TUNNEL,
> +};
> +
> +enum txgbe_fdir_pballoc_type {
> +	TXGBE_FDIR_PBALLOC_64K = 0,
> +	TXGBE_FDIR_PBALLOC_128K,
> +	TXGBE_FDIR_PBALLOC_256K,
> +};
> +
> +enum txgbe_fdir_status_mode {
> +	TXGBE_FDIR_NO_REPORT_STATUS = 0,
> +	TXGBE_FDIR_REPORT_STATUS,
> +	TXGBE_FDIR_REPORT_STATUS_ALWAYS,
> +};
> +
> +struct txgbe_fdir_conf {
> +	enum txgbe_fdir_mode mode;
> +	enum txgbe_fdir_pballoc_type pballoc;
> +	enum txgbe_fdir_status_mode status;
> +	uint8_t drop_queue;
> +	struct txgbe_fdir_masks mask;
> +	struct txgbe_fdir_flex_conf flex_conf;
> +};
> +
>  struct txgbe_hw_fdir_mask {
>  	uint16_t vlan_tci_mask;
>  	uint32_t src_ipv4_mask;
> @@ -111,7 +208,7 @@ struct txgbe_fdir_rule {
>  	struct txgbe_atr_input input; /* key of fdir filter */
>  	bool b_spec; /* If TRUE, input, fdirflags, queue have meaning. */
>  	bool b_mask; /* If TRUE, mask has meaning. */
> -	enum rte_fdir_mode mode; /* IP, MAC VLAN, Tunnel */
> +	enum txgbe_fdir_mode mode; /* IP, MAC VLAN, Tunnel */
>  	uint32_t fdirflags; /* drop or forward */
>  	uint32_t soft_id; /* an unique value for this rule */
>  	uint8_t queue; /* assigned rx queue */
> @@ -352,7 +449,7 @@ struct txgbe_tm_conf {
>  struct txgbe_adapter {
>  	struct txgbe_hw             hw;
>  	struct txgbe_hw_stats       stats;
> -	struct rte_eth_fdir_conf    fdir_conf;
> +	struct txgbe_fdir_conf    fdir_conf;
>  	struct txgbe_hw_fdir_info   fdir;
>  	struct txgbe_interrupt      intr;
>  	struct txgbe_stat_mappings  stat_mappings;
> diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
> index 67f586ffc7..ded01341a4 100644
> --- a/drivers/net/txgbe/txgbe_fdir.c
> +++ b/drivers/net/txgbe/txgbe_fdir.c
> @@ -102,22 +102,22 @@ txgbe_fdir_enable(struct txgbe_hw *hw, uint32_t fdirctrl)
>   * flexbytes matching field, and drop queue (only for perfect matching mode).
>   */
>  static inline int
> -configure_fdir_flags(const struct rte_eth_fdir_conf *conf,
> +configure_fdir_flags(const struct txgbe_fdir_conf *conf,
>  		     uint32_t *fdirctrl, uint32_t *flex)
>  {
>  	*fdirctrl = 0;
>  	*flex = 0;
> 
>  	switch (conf->pballoc) {
> -	case RTE_ETH_FDIR_PBALLOC_64K:
> +	case TXGBE_FDIR_PBALLOC_64K:
>  		/* 8k - 1 signature filters */
>  		*fdirctrl |= TXGBE_FDIRCTL_BUF_64K;
>  		break;
> -	case RTE_ETH_FDIR_PBALLOC_128K:
> +	case TXGBE_FDIR_PBALLOC_128K:
>  		/* 16k - 1 signature filters */
>  		*fdirctrl |= TXGBE_FDIRCTL_BUF_128K;
>  		break;
> -	case RTE_ETH_FDIR_PBALLOC_256K:
> +	case TXGBE_FDIR_PBALLOC_256K:
>  		/* 32k - 1 signature filters */
>  		*fdirctrl |= TXGBE_FDIRCTL_BUF_256K;
>  		break;
> @@ -129,14 +129,14 @@ configure_fdir_flags(const struct rte_eth_fdir_conf *conf,
> 
>  	/* status flags: write hash & swindex in the rx descriptor */
>  	switch (conf->status) {
> -	case RTE_FDIR_NO_REPORT_STATUS:
> +	case TXGBE_FDIR_NO_REPORT_STATUS:
>  		/* do nothing, default mode */
>  		break;
> -	case RTE_FDIR_REPORT_STATUS:
> +	case TXGBE_FDIR_REPORT_STATUS:
>  		/* report status when the packet matches a fdir rule */
>  		*fdirctrl |= TXGBE_FDIRCTL_REPORT_MATCH;
>  		break;
> -	case RTE_FDIR_REPORT_STATUS_ALWAYS:
> +	case TXGBE_FDIR_REPORT_STATUS_ALWAYS:
>  		/* always report status */
>  		*fdirctrl |= TXGBE_FDIRCTL_REPORT_ALWAYS;
>  		break;
> @@ -150,9 +150,9 @@ configure_fdir_flags(const struct rte_eth_fdir_conf *conf,
>  	*flex |= TXGBE_FDIRFLEXCFG_OFST(TXGBE_DEFAULT_FLEXBYTES_OFFSET / 2);
> 
>  	switch (conf->mode) {
> -	case RTE_FDIR_MODE_SIGNATURE:
> +	case TXGBE_FDIR_MODE_SIGNATURE:
>  		break;
> -	case RTE_FDIR_MODE_PERFECT:
> +	case TXGBE_FDIR_MODE_PERFECT:
>  		*fdirctrl |= TXGBE_FDIRCTL_PERFECT;
>  		*fdirctrl |= TXGBE_FDIRCTL_DROPQP(conf->drop_queue);
>  		break;
> @@ -179,7 +179,7 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
>  {
>  	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
>  	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
> -	enum rte_fdir_mode mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> +	enum txgbe_fdir_mode mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
>  	/*
>  	 * mask VM pool and DIPv6 since there are currently not supported
>  	 * mask FLEX byte, it will be set in flex_conf
> @@ -190,8 +190,8 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
> 
>  	PMD_INIT_FUNC_TRACE();
> 
> -	if (mode != RTE_FDIR_MODE_SIGNATURE &&
> -	    mode != RTE_FDIR_MODE_PERFECT) {
> +	if (mode != TXGBE_FDIR_MODE_SIGNATURE &&
> +	    mode != TXGBE_FDIR_MODE_PERFECT) {
>  		PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
>  		return -ENOTSUP;
>  	}
> @@ -232,14 +232,14 @@ txgbe_fdir_set_input_mask(struct rte_eth_dev *dev)
>  static int
>  txgbe_fdir_store_input_mask(struct rte_eth_dev *dev)
>  {
> -	struct rte_eth_fdir_masks *input_mask = &TXGBE_DEV_FDIR_CONF(dev)->mask;
> -	enum rte_fdir_mode mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> +	struct txgbe_fdir_masks *input_mask = &TXGBE_DEV_FDIR_CONF(dev)->mask;
> +	enum txgbe_fdir_mode mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
>  	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
>  	uint16_t dst_ipv6m = 0;
>  	uint16_t src_ipv6m = 0;
> 
> -	if (mode != RTE_FDIR_MODE_SIGNATURE &&
> -	    mode != RTE_FDIR_MODE_PERFECT) {
> +	if (mode != TXGBE_FDIR_MODE_SIGNATURE &&
> +	    mode != TXGBE_FDIR_MODE_PERFECT) {
>  		PMD_DRV_LOG(ERR, "Not supported fdir mode - %d!", mode);
>  		return -ENOTSUP;
>  	}
> @@ -304,12 +304,12 @@ txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
>  static int
>  txgbe_set_fdir_flex_conf(struct rte_eth_dev *dev, uint32_t flex)
>  {
> -	const struct rte_eth_fdir_flex_conf *conf =
> +	const struct txgbe_fdir_flex_conf *conf =
>  				&TXGBE_DEV_FDIR_CONF(dev)->flex_conf;
>  	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
>  	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
> -	const struct rte_eth_flex_payload_cfg *flex_cfg;
> -	const struct rte_eth_fdir_flex_mask *flex_mask;
> +	const struct txgbe_flex_payload_cfg *flex_cfg;
> +	const struct txgbe_fdir_flex_mask *flex_mask;
>  	uint16_t flexbytes = 0;
>  	uint16_t i;
> 
> @@ -322,7 +322,7 @@ txgbe_set_fdir_flex_conf(struct rte_eth_dev *dev, uint32_t flex)
> 
>  	for (i = 0; i < conf->nb_payloads; i++) {
>  		flex_cfg = &conf->flex_set[i];
> -		if (flex_cfg->type != RTE_ETH_RAW_PAYLOAD) {
> +		if (flex_cfg->type != TXGBE_RAW_PAYLOAD) {
>  			PMD_DRV_LOG(ERR, "unsupported payload type.");
>  			return -EINVAL;
>  		}
> @@ -375,13 +375,13 @@ txgbe_fdir_configure(struct rte_eth_dev *dev)
>  	int err;
>  	uint32_t fdirctrl, flex, pbsize;
>  	int i;
> -	enum rte_fdir_mode mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> +	enum txgbe_fdir_mode mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> 
>  	PMD_INIT_FUNC_TRACE();
> 
>  	/* supports mac-vlan and tunnel mode */
> -	if (mode != RTE_FDIR_MODE_SIGNATURE &&
> -	    mode != RTE_FDIR_MODE_PERFECT)
> +	if (mode != TXGBE_FDIR_MODE_SIGNATURE &&
> +	    mode != TXGBE_FDIR_MODE_PERFECT)
>  		return -ENOSYS;
> 
>  	err = configure_fdir_flags(TXGBE_DEV_FDIR_CONF(dev), &fdirctrl, &flex);
> @@ -531,15 +531,15 @@ txgbe_atr_compute_hash(struct txgbe_atr_input *atr_input,
> 
>  static uint32_t
>  atr_compute_perfect_hash(struct txgbe_atr_input *input,
> -		enum rte_eth_fdir_pballoc_type pballoc)
> +		enum txgbe_fdir_pballoc_type pballoc)
>  {
>  	uint32_t bucket_hash;
> 
>  	bucket_hash = txgbe_atr_compute_hash(input,
>  				TXGBE_ATR_BUCKET_HASH_KEY);
> -	if (pballoc == RTE_ETH_FDIR_PBALLOC_256K)
> +	if (pballoc == TXGBE_FDIR_PBALLOC_256K)
>  		bucket_hash &= PERFECT_BUCKET_256KB_HASH_MASK;
> -	else if (pballoc == RTE_ETH_FDIR_PBALLOC_128K)
> +	else if (pballoc == TXGBE_FDIR_PBALLOC_128K)
>  		bucket_hash &= PERFECT_BUCKET_128KB_HASH_MASK;
>  	else
>  		bucket_hash &= PERFECT_BUCKET_64KB_HASH_MASK;
> @@ -574,15 +574,15 @@ txgbe_fdir_check_cmd_complete(struct txgbe_hw *hw, uint32_t *fdircmd)
>   */
>  static uint32_t
>  atr_compute_signature_hash(struct txgbe_atr_input *input,
> -		enum rte_eth_fdir_pballoc_type pballoc)
> +		enum txgbe_fdir_pballoc_type pballoc)
>  {
>  	uint32_t bucket_hash, sig_hash;
> 
>  	bucket_hash = txgbe_atr_compute_hash(input,
>  				TXGBE_ATR_BUCKET_HASH_KEY);
> -	if (pballoc == RTE_ETH_FDIR_PBALLOC_256K)
> +	if (pballoc == TXGBE_FDIR_PBALLOC_256K)
>  		bucket_hash &= SIG_BUCKET_256KB_HASH_MASK;
> -	else if (pballoc == RTE_ETH_FDIR_PBALLOC_128K)
> +	else if (pballoc == TXGBE_FDIR_PBALLOC_128K)
>  		bucket_hash &= SIG_BUCKET_128KB_HASH_MASK;
>  	else
>  		bucket_hash &= SIG_BUCKET_64KB_HASH_MASK;
> @@ -603,7 +603,7 @@ static int
>  fdir_write_perfect_filter(struct txgbe_hw *hw,
>  			struct txgbe_atr_input *input, uint8_t queue,
>  			uint32_t fdircmd, uint32_t fdirhash,
> -			enum rte_fdir_mode mode)
> +			enum txgbe_fdir_mode mode)
>  {
>  	uint32_t fdirport, fdirflex;
>  	int err = 0;
> @@ -830,14 +830,14 @@ txgbe_fdir_filter_program(struct rte_eth_dev *dev,
>  	bool is_perfect = FALSE;
>  	int err;
>  	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
> -	enum rte_fdir_mode fdir_mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> +	enum txgbe_fdir_mode fdir_mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
>  	struct txgbe_fdir_filter *node;
> 
> -	if (fdir_mode == RTE_FDIR_MODE_NONE ||
> +	if (fdir_mode == TXGBE_FDIR_MODE_NONE ||
>  	    fdir_mode != rule->mode)
>  		return -ENOTSUP;
> 
> -	if (fdir_mode >= RTE_FDIR_MODE_PERFECT)
> +	if (fdir_mode >= TXGBE_FDIR_MODE_PERFECT)
>  		is_perfect = TRUE;
> 
>  	txgbe_fdir_mask_input(&info->mask, &rule->input);
> @@ -1021,7 +1021,7 @@ txgbevf_fdir_filter_program(struct rte_eth_dev *dev,
>  	uint32_t fdirhash;
>  	int ret;
> 
> -	if (rule->mode != RTE_FDIR_MODE_PERFECT ||
> +	if (rule->mode != TXGBE_FDIR_MODE_PERFECT ||
>  	    rule->fdirflags == TXGBE_FDIRPICMD_DROP)
>  		return -ENOTSUP;
> 
> @@ -1109,10 +1109,10 @@ txgbe_fdir_filter_restore(struct rte_eth_dev *dev)
>  	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
>  	struct txgbe_fdir_filter *node;
>  	bool is_perfect = FALSE;
> -	enum rte_fdir_mode fdir_mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> +	enum txgbe_fdir_mode fdir_mode = TXGBE_DEV_FDIR_CONF(dev)->mode;
> 
> -	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
> -	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
> +	if (fdir_mode >= TXGBE_FDIR_MODE_PERFECT &&
> +	    fdir_mode <= TXGBE_FDIR_MODE_PERFECT_TUNNEL)
>  		is_perfect = TRUE;
> 
>  	if (is_perfect) {
> @@ -1139,7 +1139,7 @@ txgbe_fdir_filter_restore(struct rte_eth_dev *dev)
>  int
>  txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
>  {
> -	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
> +	struct txgbe_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
>  	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
>  	struct txgbe_fdir_filter *fdir_filter;
>  	struct txgbe_fdir_filter *filter_flag;
> @@ -1150,7 +1150,7 @@ txgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
>  	memset(fdir_info->hash_map, 0,
>  	       sizeof(struct txgbe_fdir_filter *) *
>  	       ((1024 << (fdir_conf->pballoc + 1)) - 2));
> -	fdir_conf->mode = RTE_FDIR_MODE_NONE;
> +	fdir_conf->mode = TXGBE_FDIR_MODE_NONE;
>  	filter_flag = TAILQ_FIRST(&fdir_info->fdir_list);
>  	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
>  		TAILQ_REMOVE(&fdir_info->fdir_list,
> diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
> index a97588e57a..8470bf78af 100644
> --- a/drivers/net/txgbe/txgbe_flow.c
> +++ b/drivers/net/txgbe/txgbe_flow.c
> @@ -1412,7 +1412,7 @@ txgbe_parse_fdir_act_attr(const struct rte_flow_attr *attr,
>  		rule->queue = act_q->index;
>  	} else { /* drop */
>  		/* signature mode does not support drop action. */
> -		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
> +		if (rule->mode == TXGBE_FDIR_MODE_SIGNATURE) {
>  			memset(rule, 0, sizeof(struct txgbe_fdir_rule));
>  			rte_flow_error_set(error, EINVAL,
>  				RTE_FLOW_ERROR_TYPE_ACTION,
> @@ -1646,9 +1646,9 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
>  	}
> 
>  	if (signature_match(pattern))
> -		rule->mode = RTE_FDIR_MODE_SIGNATURE;
> +		rule->mode = TXGBE_FDIR_MODE_SIGNATURE;
>  	else
> -		rule->mode = RTE_FDIR_MODE_PERFECT;
> +		rule->mode = TXGBE_FDIR_MODE_PERFECT;
> 
>  	/*Not supported last point for range*/
>  	if (item->last) {
> @@ -1678,7 +1678,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
> 
>  			/* Ether type should be masked. */
>  			if (eth_mask->hdr.ether_type ||
> -			    rule->mode == RTE_FDIR_MODE_SIGNATURE) {
> +			    rule->mode == TXGBE_FDIR_MODE_SIGNATURE) {
>  				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
>  				rte_flow_error_set(error, EINVAL,
>  					RTE_FLOW_ERROR_TYPE_ITEM,
> @@ -1687,7 +1687,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
>  			}
> 
>  			/* If ethernet has meaning, it means MAC VLAN mode. */
> -			rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
> +			rule->mode = TXGBE_FDIR_MODE_PERFECT_MAC_VLAN;
> 
>  			/**
>  			 * src MAC address must be masked,
> @@ -1718,7 +1718,7 @@ txgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev __rte_unused,
>  		 * IPv6 is not supported.
>  		 */
>  		item = next_no_fuzzy_pattern(pattern, item);
> -		if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
> +		if (rule->mode == TXGBE_FDIR_MODE_PERFECT_MAC_VLAN) {
>  			if (item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
>  				memset(rule, 0, sizeof(struct txgbe_fdir_rule));
>  				rte_flow_error_set(error, EINVAL,
> @@ -2282,7 +2282,7 @@ txgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
>  		return -rte_errno;
>  	}
> 
> -	rule->mode = RTE_FDIR_MODE_PERFECT;
> +	rule->mode = TXGBE_FDIR_MODE_PERFECT;
>  	ptid = TXGBE_PTID_PKT_TUN;
> 
>  	/* Skip MAC. */
> @@ -2949,7 +2949,7 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
>  			struct rte_flow_error *error)
>  {
>  	int ret;
> -	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
> +	struct txgbe_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
> 
>  	ret = txgbe_parse_fdir_filter_normal(dev, attr, pattern,
>  					actions, rule, error);
> @@ -2965,11 +2965,11 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
>  	if (!txgbe_is_pf(TXGBE_DEV_HW(dev)))
>  		return ret;
> 
> -	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
> +	if (fdir_conf->mode == TXGBE_FDIR_MODE_NONE) {
>  		fdir_conf->mode = rule->mode;
>  		ret = txgbe_fdir_configure(dev);
>  		if (ret) {
> -			fdir_conf->mode = RTE_FDIR_MODE_NONE;
> +			fdir_conf->mode = TXGBE_FDIR_MODE_NONE;
>  			return ret;
>  		}
>  	} else if (fdir_conf->mode != rule->mode) {
> @@ -3562,7 +3562,7 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
>  	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
>  	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
>  	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
> -	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
> +	struct txgbe_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
>  	struct txgbe_rss_conf_ele *rss_filter_ptr;
> 
>  	switch (filter_type) {
> @@ -3625,7 +3625,7 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
>  				fdir_info->mask_added = false;
>  				fdir_info->flex_relative = false;
>  				fdir_info->flex_bytes_offset = 0;
> -				fdir_conf->mode = RTE_FDIR_MODE_NONE;
> +				fdir_conf->mode = TXGBE_FDIR_MODE_NONE;
>  			}
>  		}
>  		break;
> diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_common.h b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
> index 00847d087b..c6144cad70 100644
> --- a/drivers/net/txgbe/txgbe_rxtx_vec_common.h
> +++ b/drivers/net/txgbe/txgbe_rxtx_vec_common.h
> @@ -299,10 +299,10 @@ static inline int
>  txgbe_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
>  {
>  #ifndef RTE_LIBRTE_IEEE1588
> -	struct rte_eth_fdir_conf *fconf = TXGBE_DEV_FDIR_CONF(dev);
> +	struct txgbe_fdir_conf *fconf = TXGBE_DEV_FDIR_CONF(dev);
> 
>  	/* no fdir support */
> -	if (fconf->mode != RTE_FDIR_MODE_NONE)
> +	if (fconf->mode != TXGBE_FDIR_MODE_NONE)
>  		return -1;
> 
>  	return 0;
> --
> 2.53.0
> 
> 

