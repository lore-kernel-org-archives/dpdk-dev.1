Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B0CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 13:13:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B329F427A2;
	Fri, 17 Oct 2025 15:13:35 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 2D15240DD8
 for <dev@dpdk.org>; Fri, 17 Oct 2025 15:13:33 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=fBdZtcLrgzFXAzVVow3RPAiIK17FazFZ15YmygulgUs=;
 b=TCy4JM5zBFV+hs71aJS13FnposibqrV2/h4WXzgRiGrhsxxCa+QeRFQJCgoiA4XAiNPE6HwrW
 HS+IXUwPPEoDgUe9m2vwKqfgSrHa3NqkEIrJDadt2hMgpsP88grxRSCOoZ2lgoJwJf7e4Kl6Ljr
 ol+03KgEE7WbKhwOfot/JmI=
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cp4xx6HZkzKm5G;
 Fri, 17 Oct 2025 21:13:09 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 60CDB1402C4;
 Fri, 17 Oct 2025 21:13:31 +0800 (CST)
Received: from [10.82.68.243] (10.82.68.243) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 21:13:30 +0800
Content-Type: multipart/alternative;
 boundary="------------dHvCCMEAGqE2j3sVR1h3jByD"
Message-ID: <b0ba957e-c147-2a55-283b-281063235bba@huawei.com>
Date: Fri, 17 Oct 2025 21:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4 1/1] lib/dma: introduce inter-process and inter-OS DMA
Content-Language: en-US
To: Vamsi Krishna <vattunuru@marvell.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>, <jerinj@marvell.com>,
 <stephen@networkplumber.org>
References: <20251013042136.1727540-1-vattunuru@marvell.com>
 <20251017054210.3105218-1-vattunuru@marvell.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251017054210.3105218-1-vattunuru@marvell.com>
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

--------------dHvCCMEAGqE2j3sVR1h3jByD
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Chengwen Feng <fengchengwen@huawei.com>


On 2025/10/17 13:42, Vamsi Krishna wrote:
> From: Vamsi Attunuru<vattunuru@marvell.com>
>
> Modern DMA hardware supports data transfers between multiple DMA
> devices, facilitating data communication across isolated domains,
> containers, or operating systems. These DMA transfers function as
> standard memory-to-memory operations, but with source or destination
> addresses residing in different process or OS address space. The
> exchange of these addresses between processes is handled through
> private driver mechanism, which are beyond the scope of this
> specification change.
>
> This commit introduces new capability flags to advertise driver support
> for inter-process and inter-OS domain DMA transfers. It adds a mechanism
> to specify source and destination handlers via the vchan configuration.
> Until standardized control-plane APIs are defined for various categories
> of DMA devices, these handler details can be exchanged through private
> driver mechanisms.
>
> Signed-off-by: Vamsi Attunuru<vattunuru@marvell.com>
> ---
> V4 changes:
> * Move comments before defination
> * Validate reserved fields are zero or not.
> * Add more comments to new fields.
> * UT for this feature will be added in another commit.
> V3 changes:
> * Fix v2 review comments
> V2 changes:
> * Seperate out the control-plane APIs
> * Address v0 review comments
> * Add validation checks
> * Rename the enums
>
>   lib/dmadev/rte_dmadev.c       | 25 +++++++++++++
>   lib/dmadev/rte_dmadev.h       | 69 +++++++++++++++++++++++++++++++++++
>   lib/dmadev/rte_dmadev_trace.h |  3 ++
>   3 files changed, 97 insertions(+)
>
> diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
> index 73d24f8ff3..30c3db3a98 100644
> --- a/lib/dmadev/rte_dmadev.c
> +++ b/lib/dmadev/rte_dmadev.c
> @@ -665,6 +665,27 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
>   		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
>   		return -EINVAL;
>   	}
> +	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
> +	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
> +		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
> +		return -EINVAL;
> +	}
> +	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
> +		return -EINVAL;
> +	}
> +	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
> +	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
> +		return -EINVAL;
> +	}
> +	if ((conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN ||
> +	    conf->domain.type == RTE_DMA_INTER_OS_DOMAIN) &&
> +	    (conf->domain.reserved[0] != 0 || conf->domain.reserved[1] != 0)) {
> +		RTE_DMA_LOG(ERR, "Device %d does not support non-zero reserved fields", dev_id);
> +		return -EINVAL;
> +	}
>   	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
>   	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
>   	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
> @@ -811,6 +832,8 @@ dma_capability_name(uint64_t capability)
>   		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
>   		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
>   		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
> +		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN, "inter_process_domain" },
> +		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
>   		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
>   		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
>   		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
> @@ -1040,6 +1063,8 @@ dmadev_handle_dev_info(const char *cmd __rte_unused,
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_HANDLES_ERRORS);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_M2D_AUTO_FREE);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
> +	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
> +	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_OS_DOMAIN);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
>   	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL);
> diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
> index 30e168825e..1708311c5b 100644
> --- a/lib/dmadev/rte_dmadev.h
> +++ b/lib/dmadev/rte_dmadev.h
> @@ -265,6 +265,18 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
>    * known from 'nb_priorities' field in struct rte_dma_info.
>    */
>   #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
> +/** Support inter-process DMA transfers.
> + *
> + * When this bit is set, the DMA device can perform memory transfers between
> + * different process memory spaces.
> + */
> +#define RTE_DMA_CAPA_INTER_PROCESS_DOMAIN	RTE_BIT64(9)
> +/** Support inter-OS domain DMA transfers.
> + *
> + * The DMA device can perform memory transfers across different operating
> + * system domains.
> + */
> +#define RTE_DMA_CAPA_INTER_OS_DOMAIN		RTE_BIT64(10)
>   
>   /** Support copy operation.
>    * This capability start with index of 32, so that it could leave gap between
> @@ -426,8 +438,13 @@ int rte_dma_close(int16_t dev_id);
>    */
>   enum rte_dma_direction {
>   	/** DMA transfer direction - from memory to memory.
> +	 * When the device supports inter-process or inter-OS domain transfers,
> +	 * the field `type` in `struct rte_dma_vchan_conf::domain` specifies the
> +	 * type of domain. For memory-to-memory transfers within the same domain
> +	 * or process, `type` should be set to `RTE_DMA_INTER_DOMAIN_NONE`.
>   	 *
>   	 * @see struct rte_dma_vchan_conf::direction
> +	 * @see struct rte_dma_inter_domain_param::type
>   	 */
>   	RTE_DMA_DIR_MEM_TO_MEM,
>   	/** DMA transfer direction - from memory to device.
> @@ -572,6 +589,49 @@ struct rte_dma_auto_free_param {
>   	uint64_t reserved[2];
>   };
>   
> +/**
> + * Inter-DMA transfer domain type.
> + *
> + * This enum defines the types of transfer domains applicable to DMA operations.
> + * It helps categorize whether a DMA transfer is occurring within the same domain,
> + * across different processes, or between distinct operating system domains.
> + *
> + * @see struct rte_dma_inter_domain_param:type
> + */
> +enum rte_dma_inter_domain_type {
> +	/** No inter-domain transfer; standard DMA within same domain. */
> +	RTE_DMA_INTER_DOMAIN_NONE,
> +	/** Transfer occurs between different user-space processes. */
> +	RTE_DMA_INTER_PROCESS_DOMAIN,
> +	/** Transfer spans across different operating system domains. */
> +	RTE_DMA_INTER_OS_DOMAIN,
> +};
> +
> +/**
> + * Parameters for inter-process or inter-OS DMA transfers.
> + *
> + * This structure defines the parameters required to perform DMA transfers
> + * across different domains, such as between processes or operating systems.
> + * It includes the domain type and handler identifiers for both the source
> + * and destination domains.
> + *
> + * When domain type is RTE_DMA_INTER_DOMAIN_NONE, both source and destination
> + * handlers are invalid, DMA operation is confined within the local process.
> + *
> + * For DMA transfers between the local process or OS domain to another process
> + * or OS domain, valid source and destination handlers must be provided.
> + */
> +struct rte_dma_inter_domain_param {
> +	/** Type of inter-domain. */
> +	enum rte_dma_inter_domain_type type;
> +	/** Source domain handler identifier. */
> +	uint16_t src_handler;
> +	/** Destination domain handler identifier. */
> +	uint16_t dst_handler;
> +	/** Reserved for future fields. */
> +	uint64_t reserved[2];
> +};
> +
>   /**
>    * A structure used to configure a virtual DMA channel.
>    *
> @@ -609,6 +669,15 @@ struct rte_dma_vchan_conf {
>   	 * @see struct rte_dma_auto_free_param
>   	 */
>   	struct rte_dma_auto_free_param auto_free;
> +	/** Parameters for inter-process or inter-OS domain DMA transfers. This field
> +	 * specifies the source and destination domain handlers required for DMA
> +	 * operations that span across different processes or operating system domains.
> +	 *
> +	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
> +	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
> +	 * @see struct rte_dma_inter_domain_param
> +	 */
> +	struct rte_dma_inter_domain_param domain;
>   };
>   
>   /**
> diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
> index 04d9a2741b..f1a178eeb5 100644
> --- a/lib/dmadev/rte_dmadev_trace.h
> +++ b/lib/dmadev/rte_dmadev_trace.h
> @@ -79,6 +79,9 @@ RTE_TRACE_POINT(
>   	rte_trace_point_emit_int(conf->dst_port.port_type);
>   	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
>   	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
> +	rte_trace_point_emit_int(conf->domain.type);
> +	rte_trace_point_emit_u16(conf->domain.src_handler);
> +	rte_trace_point_emit_u16(conf->domain.dst_handler);
>   	rte_trace_point_emit_int(ret);
>   )
>   
--------------dHvCCMEAGqE2j3sVR1h3jByD
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><span style="font-family:SimSun">Acked-by: </span><span
        style="font-family:Calibri">Chengwen Feng <a
          class="moz-txt-link-rfc2396E"
          href="mailto:fengchengwen@huawei.com">&lt;fengchengwen@huawei.com&gt;</a><br>
      </span></p>
    <p><br>
    </p>
    <p></p>
    <div class="moz-cite-prefix">On 2025/10/17 13:42, Vamsi Krishna
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251017054210.3105218-1-vattunuru@marvell.com">
      <pre class="moz-quote-pre" wrap="">From: Vamsi Attunuru <a class="moz-txt-link-rfc2396E" href="mailto:vattunuru@marvell.com">&lt;vattunuru@marvell.com&gt;</a>

Modern DMA hardware supports data transfers between multiple DMA
devices, facilitating data communication across isolated domains,
containers, or operating systems. These DMA transfers function as
standard memory-to-memory operations, but with source or destination
addresses residing in different process or OS address space. The
exchange of these addresses between processes is handled through
private driver mechanism, which are beyond the scope of this
specification change.

This commit introduces new capability flags to advertise driver support
for inter-process and inter-OS domain DMA transfers. It adds a mechanism
to specify source and destination handlers via the vchan configuration.
Until standardized control-plane APIs are defined for various categories
of DMA devices, these handler details can be exchanged through private
driver mechanisms.

Signed-off-by: Vamsi Attunuru <a class="moz-txt-link-rfc2396E" href="mailto:vattunuru@marvell.com">&lt;vattunuru@marvell.com&gt;</a>
---
V4 changes:
* Move comments before defination
* Validate reserved fields are zero or not.
* Add more comments to new fields.
* UT for this feature will be added in another commit.
V3 changes:
* Fix v2 review comments
V2 changes:
* Seperate out the control-plane APIs
* Address v0 review comments
* Add validation checks
* Rename the enums

 lib/dmadev/rte_dmadev.c       | 25 +++++++++++++
 lib/dmadev/rte_dmadev.h       | 69 +++++++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev_trace.h |  3 ++
 3 files changed, 97 insertions(+)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 73d24f8ff3..30c3db3a98 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -665,6 +665,27 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
 		return -EINVAL;
 	}
+	if (conf-&gt;domain.type != RTE_DMA_INTER_DOMAIN_NONE &amp;&amp;
+	    conf-&gt;direction != RTE_DMA_DIR_MEM_TO_MEM) {
+		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
+		return -EINVAL;
+	}
+	if (conf-&gt;domain.type == RTE_DMA_INTER_OS_DOMAIN &amp;&amp;
+	    !(dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
+		return -EINVAL;
+	}
+	if (conf-&gt;domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &amp;&amp;
+	    !(dev_info.dev_capa &amp; RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
+		return -EINVAL;
+	}
+	if ((conf-&gt;domain.type == RTE_DMA_INTER_PROCESS_DOMAIN ||
+	    conf-&gt;domain.type == RTE_DMA_INTER_OS_DOMAIN) &amp;&amp;
+	    (conf-&gt;domain.reserved[0] != 0 || conf-&gt;domain.reserved[1] != 0)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
 	if (conf-&gt;direction != RTE_DMA_DIR_MEM_TO_MEM &amp;&amp;
 	    conf-&gt;direction != RTE_DMA_DIR_MEM_TO_DEV &amp;&amp;
 	    conf-&gt;direction != RTE_DMA_DIR_DEV_TO_MEM &amp;&amp;
@@ -811,6 +832,8 @@ dma_capability_name(uint64_t capability)
 		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
 		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
 		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
+		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN, "inter_process_domain" },
+		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
 		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
 		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
 		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
@@ -1040,6 +1063,8 @@ dmadev_handle_dev_info(const char *cmd __rte_unused,
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_HANDLES_ERRORS);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_M2D_AUTO_FREE);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
+	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
+	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_OS_DOMAIN);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL);
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 30e168825e..1708311c5b 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -265,6 +265,18 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
  * known from 'nb_priorities' field in struct rte_dma_info.
  */
 #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
+/** Support inter-process DMA transfers.
+ *
+ * When this bit is set, the DMA device can perform memory transfers between
+ * different process memory spaces.
+ */
+#define RTE_DMA_CAPA_INTER_PROCESS_DOMAIN	RTE_BIT64(9)
+/** Support inter-OS domain DMA transfers.
+ *
+ * The DMA device can perform memory transfers across different operating
+ * system domains.
+ */
+#define RTE_DMA_CAPA_INTER_OS_DOMAIN		RTE_BIT64(10)
 
 /** Support copy operation.
  * This capability start with index of 32, so that it could leave gap between
@@ -426,8 +438,13 @@ int rte_dma_close(int16_t dev_id);
  */
 enum rte_dma_direction {
 	/** DMA transfer direction - from memory to memory.
+	 * When the device supports inter-process or inter-OS domain transfers,
+	 * the field `type` in `struct rte_dma_vchan_conf::domain` specifies the
+	 * type of domain. For memory-to-memory transfers within the same domain
+	 * or process, `type` should be set to `RTE_DMA_INTER_DOMAIN_NONE`.
 	 *
 	 * @see struct rte_dma_vchan_conf::direction
+	 * @see struct rte_dma_inter_domain_param::type
 	 */
 	RTE_DMA_DIR_MEM_TO_MEM,
 	/** DMA transfer direction - from memory to device.
@@ -572,6 +589,49 @@ struct rte_dma_auto_free_param {
 	uint64_t reserved[2];
 };
 
+/**
+ * Inter-DMA transfer domain type.
+ *
+ * This enum defines the types of transfer domains applicable to DMA operations.
+ * It helps categorize whether a DMA transfer is occurring within the same domain,
+ * across different processes, or between distinct operating system domains.
+ *
+ * @see struct rte_dma_inter_domain_param:type
+ */
+enum rte_dma_inter_domain_type {
+	/** No inter-domain transfer; standard DMA within same domain. */
+	RTE_DMA_INTER_DOMAIN_NONE,
+	/** Transfer occurs between different user-space processes. */
+	RTE_DMA_INTER_PROCESS_DOMAIN,
+	/** Transfer spans across different operating system domains. */
+	RTE_DMA_INTER_OS_DOMAIN,
+};
+
+/**
+ * Parameters for inter-process or inter-OS DMA transfers.
+ *
+ * This structure defines the parameters required to perform DMA transfers
+ * across different domains, such as between processes or operating systems.
+ * It includes the domain type and handler identifiers for both the source
+ * and destination domains.
+ *
+ * When domain type is RTE_DMA_INTER_DOMAIN_NONE, both source and destination
+ * handlers are invalid, DMA operation is confined within the local process.
+ *
+ * For DMA transfers between the local process or OS domain to another process
+ * or OS domain, valid source and destination handlers must be provided.
+ */
+struct rte_dma_inter_domain_param {
+	/** Type of inter-domain. */
+	enum rte_dma_inter_domain_type type;
+	/** Source domain handler identifier. */
+	uint16_t src_handler;
+	/** Destination domain handler identifier. */
+	uint16_t dst_handler;
+	/** Reserved for future fields. */
+	uint64_t reserved[2];
+};
+
 /**
  * A structure used to configure a virtual DMA channel.
  *
@@ -609,6 +669,15 @@ struct rte_dma_vchan_conf {
 	 * @see struct rte_dma_auto_free_param
 	 */
 	struct rte_dma_auto_free_param auto_free;
+	/** Parameters for inter-process or inter-OS domain DMA transfers. This field
+	 * specifies the source and destination domain handlers required for DMA
+	 * operations that span across different processes or operating system domains.
+	 *
+	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
+	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
+	 * @see struct rte_dma_inter_domain_param
+	 */
+	struct rte_dma_inter_domain_param domain;
 };
 
 /**
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index 04d9a2741b..f1a178eeb5 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -79,6 +79,9 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(conf-&gt;dst_port.port_type);
 	rte_trace_point_emit_u64(conf-&gt;dst_port.pcie.val);
 	rte_trace_point_emit_ptr(conf-&gt;auto_free.m2d.pool);
+	rte_trace_point_emit_int(conf-&gt;domain.type);
+	rte_trace_point_emit_u16(conf-&gt;domain.src_handler);
+	rte_trace_point_emit_u16(conf-&gt;domain.dst_handler);
 	rte_trace_point_emit_int(ret);
 )
 
</pre>
    </blockquote>
  </body>
</html>

--------------dHvCCMEAGqE2j3sVR1h3jByD--
