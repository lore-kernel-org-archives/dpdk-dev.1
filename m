Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A1BC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 12:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 727A540A89;
	Wed, 23 Jul 2025 14:30:23 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 38E4440653
 for <dev@dpdk.org>; Wed, 23 Jul 2025 14:30:22 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A8D6AE0568;
 Wed, 23 Jul 2025 16:30:20 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A8D6AE0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753273821;
 bh=lKuYG0jElAKEHivDAMWIr8VakbG1Uz35XeP8gi5bFDo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=L/207tfaZh2QYbXayq7TPhb9rPw0v9hDqX4mq1b4WQ7jQTlpvi0yrICba8PpTu/YZ
 012ZdXEKcDALQdSj9r60iTpqKEc4HaWkpPW7shdcYQK4Lo5htvFpzKvJX+2WkSE67f
 rM++6ZGNUi81Cj7IgoE5qHBSMTDBuWiKCf5sRTUVEvvM1d2jiTmm0TpF15sbO2VMwg
 SSjgKe+sy3VYm4vHJP74so/gv35xzi2hg2iWWuHjTNad+KFZoyVzQOMGMRkv/TrybI
 Qh24LMURfT0b0PZhN8sHYumXbeTu/Vssz0bJ5wOBVNi3CrA9gNUupb2T1/eafa2zzq
 2ePXjL+3NO/eQ==
Date: Wed, 23 Jul 2025 16:30:19 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Shivaji Kant <shivajikant@google.com>
cc: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, 
 dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH] net/af_xdp: enable AF_XDP program attachment mode
In-Reply-To: <20250723074249.3264675-1-shivajikant@google.com>
Message-ID: <d21fa0bc-6593-30f7-4219-ab80e7390ef7@arknetworks.am>
References: <20250723074249.3264675-1-shivajikant@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Shivaji,

(please see below)

On Wed, 23 Jul 2025, Shivaji Kant wrote:

> Currently, the AF_XDP PMD attaches its XDP program using a fixed
> set of flags,defaulting to `XDP_FLAGS_UPDATE_IF_NOEXIST`. This lacks
> flexibility for users who might need to explicitly control the XDP
> mode based on their specific hardware capabilities or performance
> requirements.
>
> This patch introduces a new vdev argument, `mode`, for the `net_af_xdp`
> PMD. This argument allows users to explicitly specify the desired
> XDP program attachment mode:
> `drv` (XDP_FLAGS_DRV_MODE),
> `skb` (XDP_FLAGS_SKB_MODE),
> `hw` (XDP_FLAGS_HW_MODE).
> (If needed more can be added)
>
> This change provides greater control and flexibility for users to
> fine-tune AF_XDP behavior, enabling them to leverage native driver
> or hardware offload capabilities when available, or fall back to
> generic SKB mode for broader compatibility.
>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
> drivers/net/af_xdp/rte_eth_af_xdp.c | 61 +++++++++++++++++++++++++----
> 1 file changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 5f65850a27..e39f2b4935 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -104,6 +104,8 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
>
> static int afxdp_dev_count;
>
> +static __u32 mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST;

If one seeks to add a per-device argument, then why is this static/driver-wide?
This belongs in 'struct pmd_internals'.

Thank you.

> +
> /* Message header to synchronize fds via IPC */
> struct ipc_hdr {
> 	char port_name[RTE_DEV_NAME_MAX_LEN];
> @@ -198,6 +200,26 @@ struct pmd_process_private {
> #define ETH_AF_XDP_USE_CNI_ARG			"use_cni"
> #define ETH_AF_XDP_USE_PINNED_MAP_ARG	"use_pinned_map"
> #define ETH_AF_XDP_DP_PATH_ARG			"dp_path"
> +#define ETH_AF_XDP_MODE_ARG				"mode"
> +
> +/* Define different modes for af_xdp prog to attach */
> +#define ETH_AF_XDP_DRV_MODE_ARG			"drv"
> +#define ETH_AF_XDP_SKB_MODE_ARG			"skb"
> +#define ETH_AF_XDP_HW_MODE_ARG			"hw"
> +#define ETH_AF_XDP_NUM_MODE_ARG			3
> +
> +static const char * const mode_arguments[] = {
> +	ETH_AF_XDP_DRV_MODE_ARG,
> +	ETH_AF_XDP_SKB_MODE_ARG,
> +	ETH_AF_XDP_HW_MODE_ARG,
> +	NULL
> +};
> +
> +static const unsigned int mode_flags[] = {
> +	XDP_FLAGS_DRV_MODE,
> +	XDP_FLAGS_SKB_MODE,
> +	XDP_FLAGS_HW_MODE
> +};
>
> static const char * const valid_arguments[] = {
> 	ETH_AF_XDP_IFACE_ARG,
> @@ -210,6 +232,7 @@ static const char * const valid_arguments[] = {
> 	ETH_AF_XDP_USE_CNI_ARG,
> 	ETH_AF_XDP_USE_PINNED_MAP_ARG,
> 	ETH_AF_XDP_DP_PATH_ARG,
> +	ETH_AF_XDP_MODE_ARG,
> 	NULL
> };
>
> @@ -950,14 +973,14 @@ remove_xdp_program(struct pmd_internals *internals)
> 	uint32_t curr_prog_id = 0;
> 	int ret;
>
> -	ret = bpf_xdp_query_id(internals->if_index, XDP_FLAGS_UPDATE_IF_NOEXIST,
> +	ret = bpf_xdp_query_id(internals->if_index, mode_flag,
> 			       &curr_prog_id);
> 	if (ret != 0) {
> 		AF_XDP_LOG_LINE(ERR, "bpf_xdp_query_id failed");
> 		return ret;
> 	}
>
> -	ret = bpf_xdp_detach(internals->if_index, XDP_FLAGS_UPDATE_IF_NOEXIST,
> +	ret = bpf_xdp_detach(internals->if_index, mode_flag,
> 			     NULL);
> 	if (ret != 0)
> 		AF_XDP_LOG_LINE(ERR, "bpf_xdp_detach failed");
> @@ -978,14 +1001,14 @@ remove_xdp_program(struct pmd_internals *internals)
> 	int ret;
>
> 	ret = bpf_get_link_xdp_id(internals->if_index, &curr_prog_id,
> -				  XDP_FLAGS_UPDATE_IF_NOEXIST);
> +				  mode_flag);
> 	if (ret != 0) {
> 		AF_XDP_LOG_LINE(ERR, "bpf_get_link_xdp_id failed");
> 		return ret;
> 	}
>
> 	ret = bpf_set_link_xdp_fd(internals->if_index, -1,
> -				  XDP_FLAGS_UPDATE_IF_NOEXIST);
> +				  mode_flag);
> 	if (ret != 0)
> 		AF_XDP_LOG_LINE(ERR, "bpf_set_link_xdp_fd failed");
> 	return ret;
> @@ -1328,7 +1351,7 @@ load_custom_xdp_prog(const char *prog_path, int if_index, struct bpf_map **map)
>
> 	/* Link the program with the given network device */
> 	ret = link_xdp_prog_with_dev(if_index, prog_fd,
> -					XDP_FLAGS_UPDATE_IF_NOEXIST);
> +					mode_flag);
> 	if (ret) {
> 		AF_XDP_LOG_LINE(ERR, "Failed to set prog fd %d on interface",
> 				prog_fd);
> @@ -1679,7 +1702,7 @@ xsk_configure(struct pmd_internals *internals, struct pkt_rx_queue *rxq,
> 	cfg.rx_size = ring_size;
> 	cfg.tx_size = ring_size;
> 	cfg.libbpf_flags = 0;
> -	cfg.xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST;
> +	cfg.xdp_flags = mode_flag;
> 	cfg.bind_flags = 0;
>
> 	/* Force AF_XDP socket into copy mode when users want it */
> @@ -2017,6 +2040,25 @@ parse_name_arg(const char *key __rte_unused,
> 	return 0;
> }
>
> +/** parse name argument */
> +static int
> +parse_mode_arg(const char *key __rte_unused,
> +	       const char *value, void *extra_args)
> +{
> +	unsigned int *mode = extra_args;
> +	unsigned int i;
> +
> +	for (i = 0; i < ETH_AF_XDP_NUM_MODE_ARG; i++) {
> +		if (strcmp(value, mode_arguments[i]) == 0) {
> +			*mode |= mode_flags[i];
> +			return 0;
> +		}
> +	}
> +
> +	AF_XDP_LOG_LINE(ERR, "Invalid af_xdp mode, choose correct mode to attach af_xdp program.");
> +	return -EINVAL;
> +}
> +
> /** parse xdp prog argument */
> static int
> parse_prog_arg(const char *key __rte_unused,
> @@ -2147,6 +2189,10 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
>
> 	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_DP_PATH_ARG,
> 				 &parse_prog_arg, dp_path);
> +
> +	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_MODE_ARG,
> +				 &parse_mode_arg, &mode_flag);
> +
> 	if (ret < 0)
> 		goto free_kvlist;
>
> @@ -2587,4 +2633,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_xdp,
> 			      "force_copy=<int> "
> 			      "use_cni=<int> "
> 			      "use_pinned_map=<int> "
> -			      "dp_path=<string> ");
> +			      "dp_path=<string> "
> +			      "mode=<string> ");
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
>
>
