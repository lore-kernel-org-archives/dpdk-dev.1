Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC8C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 19:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4872240151;
	Thu, 20 Mar 2025 20:51:05 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id C8AEC400D6
 for <dev@dpdk.org>; Thu, 20 Mar 2025 20:51:02 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so2421242a91.0
 for <dev@dpdk.org>; Thu, 20 Mar 2025 12:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742500261;
 x=1743105061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mo6r6EVVQ1jtc/FkPrCsnGuJMEYWv0BSNCmxh1hN17E=;
 b=LQUHHYhUKTqPOaIq5JyR3Ov5a5ME72/WW3I16zQ01I3ipxzgZDJHPpL3DLaBXU6wRh
 sNuWm07aCiPFvY+GvVaQNkd3XKix++3CuC23BJCxhJRCtq6lPKA6nr3FRgJ+V9XHED62
 V4rfsh3bnKmjsBY9+pUPkEciqG9v0govw2hIATFlAwwq4Qk8MdkMRAbCfrrCn5V0DHwL
 X5cRiJB1FCeW3jm9FmpEREA3fHl/PrcF5RMzDHzU8xlYLgIyi8ahob899quba5VaP0ZO
 GpHY52N03nr48G5I2FWli76niM1hIKIMkOB+3cXAqpN5cRVgAjG/M4wh+SQmHc6yVTpI
 tjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742500261; x=1743105061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mo6r6EVVQ1jtc/FkPrCsnGuJMEYWv0BSNCmxh1hN17E=;
 b=sfzasWyvJ6jjGuM5P7lCFjvICm/FF6WwThb//BRDI3KFEtUQm9Z2nDzwSoWufkCG13
 pEweLi7D9WRuLKJ2R6p66C+sFDgQntV34kFL3ptqQLxcAjdPSylI+Wf3Axni4cZ8tb2j
 8fAnXnlXgK9JMmxbvrG5tIzfXyuzhLfjJWpk2a8uDJyBb6KIgbC88dln3U/tcvq78kHA
 L0aTQQA4S7gARnO0tJcUaVQBlhk3fDBJ55PIg5ntpY3sLr8D7W12wNZ00RIumcQeR3wf
 7BVkMLNnI12cX3vNnTHL3/D/0EL43qY4x8LlQE4yX4uMY8xTFCRA2VYR5jeGI2lDmk38
 nwhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWZpvBLrAl27eUW/KNKt2LsdVTEXk3hhjbQPShDdXF0ZwCzupb49Cc+18ogHR5w21wPL0=@dpdk.org
X-Gm-Message-State: AOJu0Yyvq6m0XGlsweIzlhSf7vdMprDDb15Ot+Gvo5JrI0bA1UjYkdZc
 gFsae5bmmto4iuVXUvnV8OBQksqVIuZTH2g8kM5CLegsCBz+30oh6q091aBd9QM=
X-Gm-Gg: ASbGncvuSOxKf9MBlI2nVBiTTRRT5vGT7/UpmiUIafS1N85RKIr8xjFXSZp0b81PX/r
 yQilAXuwPC1owsctOjfILkPA+0StCK+baGtv+A0PkoTZGKpZHgRs+7XtubgvJNj5McdMdg0ueHF
 rHbtTP7UYxgTWC+PYz89EqCLpHBNms2c3izgJieIYnBOvE1QMIP+wqBcTfmUH/D79tjgY6CV2Ov
 tacUuOVESmzIAFir9VkXZNLfOaNIt5hZB1lofs4PYQLbdwCvaar2iTrddfEGZQGxoESYgZD6wAD
 8btSrFTt6+RgSYtstZ/SvC/BuWPTW/7O7Z8sN9vyK/HZLbSnj+jn4BVDliVN+aFI5GGkB9HQvD2
 ri1BaDMYySFDZWmZDhZDTaQ==
X-Google-Smtp-Source: AGHT+IGzp+vHvA5cqTkvjwJ6w72LE4x3J3RavSK386ULWTRMGf8NoYGh9fBo/TpJtRiQYUUzlO182Q==
X-Received: by 2002:a17:90a:da85:b0:2fe:8217:2da6 with SMTP id
 98e67ed59e1d1-3030fef09a8mr589832a91.22.1742500260213; 
 Thu, 20 Mar 2025 12:51:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5a1bf3sm4746695a91.25.2025.03.20.12.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 12:50:59 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:50:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v5 14/14] net/zxdh: fix debugging errors
Message-ID: <20250320125057.493b8412@hermes.local>
In-Reply-To: <20250319085808.1912523-15-chen.bingbin@zte.com.cn>
References: <20250317145802.1819809-2-chen.bingbin@zte.com.cn>
 <20250319085808.1912523-1-chen.bingbin@zte.com.cn>
 <20250319085808.1912523-15-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 19 Mar 2025 16:58:08 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Fix zxdh driver packet sending and receiving errors.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>

The term fix in commit message implies that there will be a Fixes:
tag that refers to a previous commit that was buggy.

> ---
>  drivers/net/zxdh/zxdh_common.h     |  99 ++++++++
>  drivers/net/zxdh/zxdh_ethdev.c     |  19 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c | 109 +++++----
>  drivers/net/zxdh/zxdh_ethdev_ops.h |  35 +++
>  drivers/net/zxdh/zxdh_msg.c        | 381 +++++++++++++++++------------
>  drivers/net/zxdh/zxdh_msg.h        |  99 +++++---
>  drivers/net/zxdh/zxdh_mtr.c        |  50 ++--
>  drivers/net/zxdh/zxdh_mtr.h        |   5 +
>  drivers/net/zxdh/zxdh_np.c         |  70 +++++-
>  drivers/net/zxdh/zxdh_np.h         |   8 +-
>  drivers/net/zxdh/zxdh_pci.c        |  24 +-
>  drivers/net/zxdh/zxdh_pci.h        |   2 +-
>  drivers/net/zxdh/zxdh_rxtx.c       |  12 +-
>  drivers/net/zxdh/zxdh_tables.c     |  42 ++--
>  drivers/net/zxdh/zxdh_tables.h     |  68 +++--
>  15 files changed, 708 insertions(+), 315 deletions(-)
> 
> diff --git a/drivers/net/zxdh/zxdh_common.h b/drivers/net/zxdh/zxdh_common.h
> index d78a822ebf..b34dcddd4d 100644
> --- a/drivers/net/zxdh/zxdh_common.h
> +++ b/drivers/net/zxdh/zxdh_common.h
> @@ -20,6 +20,105 @@ struct zxdh_res_para {
>  	uint16_t src_type; /* refer to BAR_DRIVER_TYPE */
>  };
>  
> +static inline size_t
> +zxdh_get_value(uint32_t fld_sz, uint8_t *addr) {
> +	size_t result = 0;
> +	switch (fld_sz) {
> +	case 1:
> +		result = *((uint8_t *)addr);
> +		break;
> +	case 2:
> +		result = *((uint16_t *)addr);
> +		break;
> +	case 4:
> +		result = *((uint32_t *)addr);
> +		break;
> +	case 8:
> +		result = *((uint64_t *)addr);
> +		break;
> +	default:
> +		printf("Error: unreachable field size %u\n", fld_sz);
No printf's

> +		break;
> +	}
> +	return result;
> +}
> +
> +static inline void
> +zxdh_set_value(uint32_t fld_sz, uint8_t *addr, size_t value) {
> +	switch (fld_sz) {
> +	case 1:
> +		*(uint8_t *)addr = (uint8_t)value;
> +		break;
> +	case 2:
> +		*(uint16_t *)addr = (uint16_t)value;
> +		break;
> +	case 4:
> +		*(uint32_t *)addr = (uint32_t)value;
> +		break;
> +	case 8:
> +		*(uint64_t *)addr = (uint64_t)value;
> +		break;
> +	default:
> +		printf("Error: unreachable field size %u\n", fld_sz);

Drivers should never use printf, only logging

> +		break;
> +	}
> +}
> +
> +#define __zxdh_nullp(typ) ((struct zxdh_ifc_##typ##_bits *)0)
> +#define __zxdh_bit_sz(typ, fld) sizeof(__zxdh_nullp(typ)->fld)
> +#define __zxdh_bit_off(typ, fld) ((unsigned int)(uintptr_t) \
> +				  (&(__zxdh_nullp(typ)->fld)))
> +#define __zxdh_dw_bit_off(typ, fld) (32 - __zxdh_bit_sz(typ, fld) - \
> +				    (__zxdh_bit_off(typ, fld) & 0x1f))
> +#define __zxdh_dw_off(typ, fld) (__zxdh_bit_off(typ, fld) / 32)
> +#define __zxdh_64_off(typ, fld) (__zxdh_bit_off(typ, fld) / 64)
> +#define __zxdh_dw_mask(typ, fld) (__zxdh_mask(typ, fld) << \
> +				  __zxdh_dw_bit_off(typ, fld))
> +#define __zxdh_mask(typ, fld) ((uint32_t)((1ull << __zxdh_bit_sz(typ, fld)) - 1))
> +#define __zxdh_16_off(typ, fld) (__zxdh_bit_off(typ, fld) / 16)
> +#define __zxdh_16_bit_off(typ, fld) (16 - __zxdh_bit_sz(typ, fld) - \
> +				    (__zxdh_bit_off(typ, fld) & 0xf))
> +#define __zxdh_mask16(typ, fld) ((uint16_t)((1ull << __zxdh_bit_sz(typ, fld)) - 1))
> +#define __zxdh_16_mask(typ, fld) (__zxdh_mask16(typ, fld) << \
> +				  __zxdh_16_bit_off(typ, fld))
> +#define ZXDH_ST_SZ_BYTES(typ) (sizeof(struct zxdh_ifc_##typ##_bits) / 8)
> +#define ZXDH_ST_SZ_DW(typ) (sizeof(struct zxdh_ifc_##typ##_bits) / 32)
> +#define ZXDH_BYTE_OFF(typ, fld) (__zxdh_bit_off(typ, fld) / 8)
> +#define ZXDH_ADDR_OF(typ, p, fld) ((uint8_t *)(p) + ZXDH_BYTE_OFF(typ, fld))
> +
> +#define BUILD_BUG_ON(condition) do { \
> +	if (condition) \
> +		__builtin_unreachable(); \
> +	} while (0)
> +
> +#define ZXDH_SET(typ, p, fld, v) do { \
> +	BUILD_BUG_ON(__zxdh_bit_sz(typ, fld) % 8); \
> +	uint32_t fld_sz = __zxdh_bit_sz(typ, fld) / 8; \
> +	uint8_t *addr = ZXDH_ADDR_OF(typ, p, fld); \
> +	zxdh_set_value(fld_sz, addr, v); \
> +} while (0)
> +
> +#define ZXDH_GET(typ, p, fld) ({ \
> +	BUILD_BUG_ON(__zxdh_bit_sz(typ, fld) % 8); \
> +	uint32_t fld_sz = __zxdh_bit_sz(typ, fld) / 8; \
> +	uint8_t *addr = ZXDH_ADDR_OF(typ, p, fld); \
> +	zxdh_get_value(fld_sz, addr); \
> +})
> +
> +#define ZXDH_SET_ARRAY(typ, p, fld, index, value, type) \
> +	do { \
> +		type *addr = (type *)((uint8_t *)ZXDH_ADDR_OF(typ, p, fld) + \
> +		(index) * sizeof(type)); \
> +		*addr = (type)(value); \
> +	} while (0)
> +
> +#define ZXDH_GET_ARRAY(typ, p, fld, index, type) \
> +	({ \
> +		type *addr = (type *)((uint8_t *)ZXDH_ADDR_OF(typ, p, fld) + \
> +		(index) * sizeof(type)); \
> +		*addr; \
> +	})
> +
>  int32_t zxdh_phyport_get(struct rte_eth_dev *dev, uint8_t *phyport);
>  int32_t zxdh_panelid_get(struct rte_eth_dev *dev, uint8_t *pannelid);
>  int32_t zxdh_hashidx_get(struct rte_eth_dev *dev, uint8_t *hash_idx);
> diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
> index ea8b18e5e1..ba7ea52d20 100644
> --- a/drivers/net/zxdh/zxdh_ethdev.c
> +++ b/drivers/net/zxdh/zxdh_ethdev.c
> @@ -1250,10 +1250,6 @@ zxdh_set_rxtx_funcs(struct rte_eth_dev *eth_dev)
>  {
>  	struct zxdh_hw *hw = eth_dev->data->dev_private;
>  
> -	if (!zxdh_pci_packed_queue(hw)) {
> -		PMD_DRV_LOG(ERR, "port %u not support packed queue", eth_dev->data->port_id);
> -		return -1;
> -	}
>  	if (!zxdh_pci_with_feature(hw, ZXDH_NET_F_MRG_RXBUF)) {
>  		PMD_DRV_LOG(ERR, "port %u not support rx mergeable", eth_dev->data->port_id);
>  		return -1;
> @@ -1498,6 +1494,8 @@ zxdh_dtb_dump_res_init(struct zxdh_hw *hw, ZXDH_DEV_INIT_CTRL_T *dpp_ctrl)
>  
>  	struct zxdh_dtb_bulk_dump_info dtb_dump_baseres[] = {
>  		{"sdt_vport_att_table", 4 * 1024 * 1024, ZXDH_SDT_VPORT_ATT_TABLE, NULL},
> +		{"sdt_vlan_att_table", 4 * 1024 * 1024, ZXDH_SDT_VLAN_ATT_TABLE, NULL},
> +		{"sdt_rss_table", 4 * 1024 * 1024, ZXDH_SDT_RSS_ATT_TABLE, NULL},
>  		{"sdt_l2_entry_table0", 5 * 1024 * 1024, ZXDH_SDT_L2_ENTRY_TABLE0, NULL},
>  		{"sdt_l2_entry_table1", 5 * 1024 * 1024, ZXDH_SDT_L2_ENTRY_TABLE1, NULL},
>  		{"sdt_l2_entry_table2", 5 * 1024 * 1024, ZXDH_SDT_L2_ENTRY_TABLE2, NULL},
> @@ -1514,7 +1512,8 @@ zxdh_dtb_dump_res_init(struct zxdh_hw *hw, ZXDH_DEV_INIT_CTRL_T *dpp_ctrl)
>  	for (i = 0; i < (int)RTE_DIM(dtb_dump_baseres); i++) {
>  		struct zxdh_dtb_bulk_dump_info *p = dtb_dump_baseres + i;
>  		char buf[ZXDH_MAX_NAME_LEN] = {0};
> -
> +		memset(buf, '\0', sizeof(buf));
> +		sprintf(buf, "%s_%x", p->mz_name, hw->dev_id);

Why the memset? It is already zero, and sprintf() adds null char

Use snprintf which can detect overflows in the buffer.
If mz_name was maximum length (32) and dev_id was long enough can
this overflow?

>  		p->mz_name = buf;
>  
>  		const struct rte_memzone *generic_dump_mz =
> @@ -1544,6 +1543,7 @@ zxdh_np_dtb_res_init(struct rte_eth_dev *dev)
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_bar_offset_params param = {0};
>  	struct zxdh_bar_offset_res res = {0};
> +	char buf[ZXDH_MAX_NAME_LEN] = {0};
>  	struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
>  	int ret = 0;
>  
> @@ -1569,7 +1569,7 @@ zxdh_np_dtb_res_init(struct rte_eth_dev *dev)
>  	dpp_ctrl->vport = hw->vport.vport;
>  	dpp_ctrl->vector = ZXDH_MSIX_INTR_DTB_VEC;
>  	strlcpy(dpp_ctrl->port_name, dev->device->name, sizeof(dpp_ctrl->port_name));
> -	dpp_ctrl->pcie_vir_addr = (uint32_t)hw->bar_addr[0];
> +	dpp_ctrl->pcie_vir_addr = (uint64_t)hw->bar_addr[0];

No cast is needed here hw->bar_addr[0] is already uint64_t.

>  
>  	param.pcie_id = hw->pcie_id;
>  	param.virt_addr = hw->bar_addr[0] + ZXDH_CTRLCH_OFFSET;
> @@ -1584,7 +1584,8 @@ zxdh_np_dtb_res_init(struct rte_eth_dev *dev)
>  	dpp_ctrl->np_bar_offset = res.bar_offset;
>  
>  	if (!dtb_data->dtb_table_conf_mz) {
> -		const struct rte_memzone *conf_mz = rte_memzone_reserve_aligned("zxdh_dtb_table_conf_mz",
> +		sprintf(buf, "%s_%x", "zxdh_dtb_table_conf_mz", hw->dev_id);
> +		const struct rte_memzone *conf_mz = rte_memzone_reserve_aligned(buf,
>  				ZXDH_DTB_TABLE_CONF_SIZE, SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);

Always use snprintf

>  
>  		if (conf_mz == NULL) {
> @@ -1600,7 +1601,9 @@ zxdh_np_dtb_res_init(struct rte_eth_dev *dev)
>  	}
>  
>  	if (!dtb_data->dtb_table_dump_mz) {
> -		const struct rte_memzone *dump_mz = rte_memzone_reserve_aligned("zxdh_dtb_table_dump_mz",
> +		memset(buf, '\0', sizeof(buf));
> +		sprintf(buf, "%s_%x", "zxdh_dtb_table_dump_mz", hw->dev_id);
> +		const struct rte_memzone *dump_mz = rte_memzone_reserve_aligned(buf,
>  				ZXDH_DTB_TABLE_DUMP_SIZE, SOCKET_ID_ANY, 0, RTE_CACHE_LINE_SIZE);
>  
>  		if (dump_mz == NULL) {
> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
> index 2b02734c62..f8e8d26c50 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.c
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
> @@ -15,6 +15,7 @@
>  #include "zxdh_np.h"
>  #include "zxdh_queue.h"
>  #include "zxdh_mtr.h"
> +#include "zxdh_common.h"
>  
>  #define ZXDH_VLAN_FILTER_GROUPS       64
>  #define ZXDH_INVALID_LOGIC_QID        0xFFFFU
> @@ -278,9 +279,11 @@ zxdh_link_info_get(struct rte_eth_dev *dev, struct rte_eth_link *link)
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  	uint16_t status = 0;
>  	int32_t ret = 0;
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	void *link_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, link_msg);
>  
>  	if (zxdh_pci_with_feature(hw, ZXDH_NET_F_STATUS))
>  		zxdh_pci_read_dev_config(hw, offsetof(struct zxdh_net_config, status),
> @@ -295,17 +298,18 @@ zxdh_link_info_get(struct rte_eth_dev *dev, struct rte_eth_link *link)
>  		zxdh_agent_msg_build(hw, ZXDH_MAC_LINK_GET, &msg_info);
>  
>  		ret = zxdh_send_msg_to_riscv(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -				&reply_info, sizeof(struct zxdh_msg_reply_info),
> +				zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info),
>  				ZXDH_BAR_MODULE_MAC);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Failed to send msg: port 0x%x msg type %d",
>  					hw->vport.vport, ZXDH_MAC_LINK_GET);
>  			return -1;
>  		}
> -		link->link_speed = reply_info.reply_body.link_msg.speed;
> -		link->link_autoneg = reply_info.reply_body.link_msg.autoneg;
> -		hw->speed_mode = reply_info.reply_body.link_msg.speed_modes;
> -		if ((reply_info.reply_body.link_msg.duplex & RTE_ETH_LINK_FULL_DUPLEX) ==
> +
> +		link->link_speed = ZXDH_GET(link_info_msg, link_msg_addr, speed);
> +		link->link_autoneg = ZXDH_GET(link_info_msg, link_msg_addr, autoneg);
> +		hw->speed_mode = ZXDH_GET(link_info_msg, link_msg_addr, speed_modes);
> +		if ((ZXDH_GET(link_info_msg, link_msg_addr, duplex) & RTE_ETH_LINK_FULL_DUPLEX) ==
>  				RTE_ETH_LINK_FULL_DUPLEX)
>  			link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
>  		else
> @@ -433,7 +437,7 @@ zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
>  		ret = zxdh_del_mac_table(hw, hw->vport.vport, old_addr,
>  			hw->hash_search_index, 0, 0);
>  		if (ret) {
> -			PMD_DRV_LOG(ERR, "mac_addr_add failed, code:%d", ret);
> +			PMD_DRV_LOG(ERR, "mac_addr_del failed, code:%d", ret);
>  			return ret;
>  		}
>  		hw->uc_num--;
> @@ -467,6 +471,8 @@ zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
>  		hw->uc_num--;
>  	}
>  	rte_ether_addr_copy(addr, (struct rte_ether_addr *)hw->mac_addr);
> +	zxdh_pci_write_dev_config(hw, offsetof(struct zxdh_net_config, mac),
> +								&hw->mac_addr, RTE_ETHER_ADDR_LEN);
>  	return ret;
>  }
>  
> @@ -566,7 +572,7 @@ zxdh_dev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
>  
>  void zxdh_dev_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
>  {
> -	struct zxdh_hw *hw	= dev->data->dev_private;
> +	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
>  	struct rte_ether_addr *mac_addr = &dev->data->mac_addrs[index];
>  	uint16_t ret = 0;
> @@ -1072,7 +1078,9 @@ zxdh_dev_rss_reta_query(struct rte_eth_dev *dev,
>  {
>  	struct zxdh_hw *hw = (struct zxdh_hw *)dev->data->dev_private;
>  	struct zxdh_msg_info msg = {0};
> -	struct zxdh_msg_reply_info reply_msg = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	void *rss_reta_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, rss_reta_msg);
>  	uint16_t idx;
>  	uint16_t i;
>  	int ret = 0;
> @@ -1094,21 +1102,21 @@ zxdh_dev_rss_reta_query(struct rte_eth_dev *dev,
>  	zxdh_msg_head_build(hw, ZXDH_RSS_RETA_GET, &msg);
>  
>  	if (hw->is_pf) {
> -		ret = zxdh_rss_table_get(hw, hw->vport.vport, &reply_msg.reply_body.rss_reta);
> +		ret = zxdh_rss_table_get(hw, hw->vport.vport, rss_reta_msg_addr);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "rss reta table set failed");
>  			return -EINVAL;
>  		}
>  	} else {
>  		ret = zxdh_vf_send_msg_to_pf(dev, &msg, sizeof(struct zxdh_msg_info),
> -					&reply_msg, sizeof(struct zxdh_msg_reply_info));
> +					zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "vf rss reta table get failed");
>  			return -EINVAL;
>  		}
>  	}
>  
> -	struct zxdh_rss_reta *reta_table = &reply_msg.reply_body.rss_reta;
> +	struct zxdh_rss_reta *reta_table = rss_reta_msg_addr;
>  
>  	for (idx = 0, i = 0; i < reta_size; ++i) {
>  		idx = i / RTE_ETH_RETA_GROUP_SIZE;
> @@ -1232,10 +1240,13 @@ zxdh_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_con
>  	struct zxdh_hw *hw = (struct zxdh_hw *)dev->data->dev_private;
>  	struct rte_eth_rss_conf *old_rss_conf = &dev->data->dev_conf.rx_adv_conf.rss_conf;
>  	struct zxdh_msg_info msg = {0};
> -	struct zxdh_msg_reply_info reply_msg = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	void *rss_hf_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, rss_hf_msg);
>  	struct zxdh_port_attr_table port_attr = {0};
> -	int ret;
> +	uint32_t rss_hf;
>  	uint32_t hw_hf;
> +	int ret;
>  
>  	if (rss_conf == NULL) {
>  		PMD_DRV_LOG(ERR, "rss conf is NULL");
> @@ -1252,16 +1263,17 @@ zxdh_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_con
>  			PMD_DRV_LOG(ERR, "rss hash factor set failed");
>  			return -EINVAL;
>  		}
> -		reply_msg.reply_body.rss_hf.rss_hf = port_attr.rss_hash_factor;
> +		ZXDH_SET(rss_hf, rss_hf_msg_addr, rss_hf, port_attr.rss_hash_factor);
>  	} else {
>  		ret = zxdh_vf_send_msg_to_pf(dev, &msg, sizeof(struct zxdh_msg_info),
> -				&reply_msg, sizeof(struct zxdh_msg_reply_info));
> +				zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "rss hash factor set failed");
>  			return -EINVAL;
>  		}
>  	}
> -	rss_conf->rss_hf = zxdh_rss_hf_to_eth(reply_msg.reply_body.rss_hf.rss_hf);
> +	rss_hf = ZXDH_GET(rss_hf, rss_hf_msg_addr, rss_hf);
> +	rss_conf->rss_hf = zxdh_rss_hf_to_eth(rss_hf);
>  
>  	return 0;
>  }
> @@ -1382,7 +1394,8 @@ zxdh_hw_vqm_stats_get(struct rte_eth_dev *dev, enum zxdh_agent_msg_type opcode,
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
>  	enum ZXDH_BAR_MODULE_ID module_id;
>  	int ret = 0;
>  
> @@ -1404,14 +1417,15 @@ zxdh_hw_vqm_stats_get(struct rte_eth_dev *dev, enum zxdh_agent_msg_type opcode,
>  	zxdh_agent_msg_build(hw, opcode, &msg_info);
>  
>  	ret = zxdh_send_msg_to_riscv(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -				&reply_info, sizeof(struct zxdh_msg_reply_info), module_id);
> +				zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info), module_id);
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "Failed to get hw stats");
>  		return -1;
>  	}
> -	struct zxdh_msg_reply_body *reply_body = &reply_info.reply_body;
>  
> -	memcpy(hw_stats, &reply_body->vqm_stats, sizeof(struct zxdh_hw_vqm_stats));
> +	void *hw_vqm_stats = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, vqm_stats);
> +	memcpy(hw_stats, hw_vqm_stats, sizeof(struct zxdh_hw_vqm_stats));
> +
>  	return 0;
>  }
>  
> @@ -1578,7 +1592,9 @@ zxdh_hw_np_stats_get(struct rte_eth_dev *dev, struct zxdh_hw_np_stats *np_stats)
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	void *hw_stas_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, hw_stats);
>  	int ret = 0;
>  
>  	if (hw->is_pf) {
> @@ -1590,13 +1606,13 @@ zxdh_hw_np_stats_get(struct rte_eth_dev *dev, struct zxdh_hw_np_stats *np_stats)
>  	} else {
>  		zxdh_msg_head_build(hw, ZXDH_GET_NP_STATS, &msg_info);
>  		ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -					&reply_info, sizeof(struct zxdh_msg_reply_info));
> +					zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
>  		if (ret) {
>  			PMD_DRV_LOG(ERR,
>  				"Failed to send msg: port 0x%x msg type", hw->vport.vport);
>  			return -1;
>  		}
> -		memcpy(np_stats, &reply_info.reply_body.np_stats, sizeof(struct zxdh_hw_np_stats));
> +		memcpy(np_stats, hw_stas_addr, sizeof(struct zxdh_hw_np_stats));
>  	}
>  	return ret;
>  }
> @@ -1666,7 +1682,7 @@ zxdh_hw_stats_reset(struct rte_eth_dev *dev, enum zxdh_agent_msg_type opcode)
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  	enum ZXDH_BAR_MODULE_ID module_id;
>  	int ret = 0;
>  
> @@ -1685,7 +1701,7 @@ zxdh_hw_stats_reset(struct rte_eth_dev *dev, enum zxdh_agent_msg_type opcode)
>  	zxdh_agent_msg_build(hw, opcode, &msg_info);
>  
>  	ret = zxdh_send_msg_to_riscv(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -				&reply_info, sizeof(struct zxdh_msg_reply_info), module_id);
> +				zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info), module_id);
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "Failed to reset hw stats");
>  		return -1;
> @@ -1767,13 +1783,13 @@ zxdh_hw_np_stats_vf_reset(struct rte_eth_dev *dev)
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  	int ret = 0;
>  
>  	msg_info.data.np_stats_query.clear_mode = 1;
>  	zxdh_msg_head_build(hw, ZXDH_GET_NP_STATS, &msg_info);
>  	ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -			&reply_info, sizeof(reply_info));
> +			zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
>  	if (ret)
>  		PMD_DRV_LOG(ERR, "Failed to send ZXDH_PORT_METER_STAT_GET msg. code:%d", ret);
>  
> @@ -2034,29 +2050,24 @@ zxdh_dev_fw_version_get(struct rte_eth_dev *dev,
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	void *flash_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, flash_msg);
>  	char fw_ver[ZXDH_FWVERS_LEN] = {0};
>  	uint32_t ret = 0;
>  
>  	zxdh_agent_msg_build(hw, ZXDH_FLASH_FIR_VERSION_GET, &msg_info);
>  
> -	struct zxdh_msg_recviver_mem rsp_data = {
> -			.recv_buffer = (void *)&reply_info,
> -			.buffer_len = sizeof(struct zxdh_msg_reply_info),
> -	};
> -
>  	ret = zxdh_send_msg_to_riscv(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -				&reply_info, sizeof(struct zxdh_msg_reply_info),
> +				zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info),
>  				ZXDH_MODULE_FLASH);
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "Failed to send msg: port 0x%x msg type %d",
>  				hw->vport.vport, ZXDH_FLASH_FIR_VERSION_GET);
>  		return -1;
>  	}
> -	struct zxdh_msg_reply_body *ack_msg =
> -			 &(((struct zxdh_msg_reply_info *)rsp_data.recv_buffer)->reply_body);
>  
> -	memcpy(fw_ver, ack_msg->flash_msg.firmware_version, ZXDH_FWVERS_LEN);
> +	memcpy(fw_ver, flash_msg_addr, ZXDH_FWVERS_LEN);
>  	snprintf(fw_version, ZXDH_FWVERS_LEN - 1, "%s", fw_ver);
>  
>  	return 0;
> @@ -2068,7 +2079,7 @@ zxdh_en_module_eeprom_read(struct rte_eth_dev *dev,
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_info msg_info = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  	uint8_t ret = 0;
>  
>  	zxdh_agent_msg_build(hw, ZXDH_MAC_MODULE_EEPROM_READ, &msg_info);
> @@ -2079,26 +2090,24 @@ zxdh_en_module_eeprom_read(struct rte_eth_dev *dev,
>  	msg_info.data.module_eeprom_msg.offset = query->offset;
>  	msg_info.data.module_eeprom_msg.length = query->length;
>  
> -	struct zxdh_msg_recviver_mem rsp_data = {
> -			.recv_buffer = (void *)&reply_info,
> -			.buffer_len = sizeof(struct zxdh_msg_reply_info),
> -	};
> -
>  	ret = zxdh_send_msg_to_riscv(dev, &msg_info, sizeof(struct zxdh_msg_info),
> -				&reply_info, sizeof(struct zxdh_msg_reply_info),
> +				zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info),
>  				ZXDH_BAR_MODULE_MAC);
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "Failed to send msg: port 0x%x msg type %d",
>  				hw->vport.vport, ZXDH_MAC_MODULE_EEPROM_READ);
>  		return -1;
>  	}
> -	struct zxdh_msg_reply_body *ack_msg =
> -			 &(((struct zxdh_msg_reply_info *)rsp_data.recv_buffer)->reply_body);
> -
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	void *module_eeprom_msg_addr =
> +			ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, module_eeprom_msg);
> +	void *agent_mac_module_eeprom_msg_data_addr =
> +			ZXDH_ADDR_OF(agent_mac_module_eeprom_msg, module_eeprom_msg_addr, data);
> +	uint8_t length = ZXDH_GET(agent_mac_module_eeprom_msg, module_eeprom_msg_addr, length);
>  	if (data)
> -		memcpy(data, ack_msg->module_eeprom_msg.data, ack_msg->module_eeprom_msg.length);
> +		memcpy(data, agent_mac_module_eeprom_msg_data_addr, length);
>  
> -	return ack_msg->module_eeprom_msg.length;
> +	return length;
>  }
>  
>  int
> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.h b/drivers/net/zxdh/zxdh_ethdev_ops.h
> index a5162a6d6b..97a1eb4532 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.h
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.h
> @@ -62,6 +62,30 @@ struct zxdh_hw_np_stats {
>  	uint64_t tx_ssvpc_pkts;
>  };
>  
> +struct zxdh_ifc_hw_np_stats_bits {
> +	uint8_t rx_unicast_pkts[0x40];
> +	uint8_t tx_unicast_pkts[0x40];
> +	uint8_t rx_unicast_bytes[0x40];
> +	uint8_t tx_unicast_bytes[0x40];
> +	uint8_t rx_multicast_pkts[0x40];
> +	uint8_t tx_multicast_pkts[0x40];
> +	uint8_t rx_multicast_bytes[0x40];
> +	uint8_t tx_multicast_bytes[0x40];
> +	uint8_t rx_broadcast_pkts[0x40];
> +	uint8_t tx_broadcast_pkts[0x40];
> +	uint8_t rx_broadcast_bytes[0x40];
> +	uint8_t tx_broadcast_bytes[0x40];
> +	uint8_t rx_mtu_drop_pkts[0x40];
> +	uint8_t tx_mtu_drop_pkts[0x40];
> +	uint8_t rx_mtu_drop_bytes[0x40];
> +	uint8_t tx_mtu_drop_bytes[0x40];
> +	uint8_t rx_mtr_drop_pkts[0x40];
> +	uint8_t tx_mtr_drop_pkts[0x40];
> +	uint8_t rx_mtr_drop_bytes[0x40];
> +	uint8_t tx_mtr_drop_bytes[0x40];
> +	uint8_t tx_ssvpc_pkts[0x40];
> +};

Seems like 0x40 (ie 64) is a magic constant here. Is it based
on number of VF's or other value. Should be defined as constant
rather than open coded.

> +
>  struct zxdh_hw_vqm_stats {
>  	uint64_t rx_total;
>  	uint64_t tx_total;
> @@ -72,6 +96,17 @@ struct zxdh_hw_vqm_stats {
>  	uint64_t rx_drop;
>  };
>  
> +struct zxdh_ifc_hw_vqm_stats_bits {
> +	uint8_t rx_total[0x40];
> +	uint8_t tx_total[0x40];
> +	uint8_t rx_bytes[0x40];
> +	uint8_t tx_bytes[0x40];
> +	uint8_t rx_error[0x40];
> +	uint8_t tx_error[0x40];
> +	uint8_t rx_drop[0x40];
> +};
> +
> +
>  int zxdh_dev_set_link_up(struct rte_eth_dev *dev);
>  int zxdh_dev_set_link_down(struct rte_eth_dev *dev);
>  int32_t zxdh_dev_link_update(struct rte_eth_dev *dev, int32_t wait_to_complete);
> diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
> index 96ad638e83..02ecd93b12 100644
> --- a/drivers/net/zxdh/zxdh_msg.c
> +++ b/drivers/net/zxdh/zxdh_msg.c
> @@ -18,6 +18,7 @@
>  #include "zxdh_pci.h"
>  #include "zxdh_tables.h"
>  #include "zxdh_np.h"
> +#include "zxdh_common.h"
>  
>  #define ZXDH_REPS_INFO_FLAG_USABLE  0x00
>  #define ZXDH_BAR_SEQID_NUM_MAX      256
> @@ -695,7 +696,7 @@ static uint16_t
>  zxdh_bar_chan_sync_msg_reps_get(uint64_t subchan_addr,
>  		uint64_t recv_buffer, uint16_t buffer_len)
>  {
> -	struct zxdh_bar_msg_header msg_header = {0};
> +	struct zxdh_bar_msg_header msg_header;
>  	uint16_t msg_id = 0;
>  	uint16_t msg_len = 0;
>  
> @@ -987,7 +988,7 @@ zxdh_bar_chan_msg_header_check(struct zxdh_bar_msg_header *msg_header)
>  int
>  zxdh_bar_irq_recv(uint8_t src, uint8_t dst, uint64_t virt_addr, void *dev)
>  {
> -	struct zxdh_bar_msg_header msg_header = {0};
> +	struct zxdh_bar_msg_header msg_header;
>  	uint64_t recv_addr = 0;
>  	uint64_t reps_addr = 0;
>  	uint16_t ret = 0;
> @@ -1083,22 +1084,20 @@ zxdh_vf_send_msg_to_pf(struct rte_eth_dev *dev,  void *msg_req,
>  {
>  	struct zxdh_hw *hw  = dev->data->dev_private;
>  	struct zxdh_msg_recviver_mem result = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  	int ret = 0;
>  
>  	if (reply) {
> -		RTE_ASSERT(reply_len < sizeof(struct zxdh_msg_reply_info));
> +		RTE_ASSERT(reply_len < ZXDH_ST_SZ_BYTES(msg_reply_info));
>  		result.recv_buffer  = reply;
>  		result.buffer_len = reply_len;
>  	} else {
> -		result.recv_buffer = &reply_info;
> -		result.buffer_len = sizeof(reply_info);
> +		result.recv_buffer = zxdh_msg_reply_info;
> +		result.buffer_len = ZXDH_ST_SZ_BYTES(msg_reply_info);
>  	}
>  
> -	struct zxdh_msg_reply_head *reply_head =
> -				&(((struct zxdh_msg_reply_info *)result.recv_buffer)->reply_head);
> -	struct zxdh_msg_reply_body *reply_body =
> -				&(((struct zxdh_msg_reply_info *)result.recv_buffer)->reply_body);
> +	void *reply_head_addr = ZXDH_ADDR_OF(msg_reply_info, result.recv_buffer, reply_head);
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, result.recv_buffer, reply_body);
>  
>  	struct zxdh_pci_bar_msg in = {
>  		.virt_addr = (uint64_t)(hw->bar_addr[ZXDH_BAR0_INDEX] +
> @@ -1118,12 +1117,16 @@ zxdh_vf_send_msg_to_pf(struct rte_eth_dev *dev,  void *msg_req,
>  			"vf[%d] send bar msg to pf failed.ret %d", hw->vport.vfid, ret);
>  		return -1;
>  	}
> -	if (reply_head->flag != ZXDH_MSG_REPS_OK) {
> +
> +	uint8_t flag = ZXDH_GET(msg_reply_head, reply_head_addr, flag);
> +	uint16_t reps_len = ZXDH_GET(msg_reply_head, reply_head_addr, reps_len);
> +	if (flag != ZXDH_MSG_REPS_OK) {
>  		PMD_MSG_LOG(ERR, "vf[%d] get pf reply failed: reply_head flag : 0x%x(0xff is OK).replylen %d",
> -				hw->vport.vfid, reply_head->flag, reply_head->reps_len);
> +				hw->vport.vfid, flag, reps_len);
>  		return -1;
>  	}
> -	if (reply_body->flag != ZXDH_REPS_SUCC) {
> +	uint8_t reply_body_flag = ZXDH_GET(msg_reply_body, reply_body_addr, flag);
> +	if (reply_body_flag != ZXDH_REPS_SUCC) {
>  		PMD_MSG_LOG(ERR, "vf[%d] msg processing failed", hw->vfid);
>  		return -1;
>  	}
> @@ -1137,23 +1140,19 @@ zxdh_send_msg_to_riscv(struct rte_eth_dev *dev, void *msg_req,
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	struct zxdh_msg_recviver_mem result = {0};
> -	struct zxdh_msg_reply_info reply_info = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  
>  	if (reply) {
> -		RTE_ASSERT(reply_len < sizeof(struct zxdh_msg_reply_info));
> +		RTE_ASSERT(reply_len < ZXDH_ST_SZ_BYTES(msg_reply_info));
>  		result.recv_buffer  = reply;
>  		result.buffer_len = reply_len;
>  	} else {
> -		result.recv_buffer = &reply_info;
> -		result.buffer_len = sizeof(reply_info);
> +		result.recv_buffer = zxdh_msg_reply_info;
> +		result.buffer_len = ZXDH_ST_SZ_BYTES(msg_reply_info);
>  	}
> -	struct zxdh_msg_reply_head *reply_head =
> -				&(((struct zxdh_msg_reply_info *)result.recv_buffer)->reply_head);
> -	struct zxdh_msg_reply_body *reply_body =
> -				&(((struct zxdh_msg_reply_info *)result.recv_buffer)->reply_body);
>  
>  	struct zxdh_pci_bar_msg in = {
> -		.payload_addr = &msg_req,
> +		.payload_addr = msg_req,
>  		.payload_len = msg_req_len,
>  		.virt_addr = (uint64_t)(hw->bar_addr[ZXDH_BAR0_INDEX] + ZXDH_CTRLCH_OFFSET),
>  		.src = hw->is_pf ? ZXDH_MSG_CHAN_END_PF : ZXDH_MSG_CHAN_END_VF,
> @@ -1166,15 +1165,6 @@ zxdh_send_msg_to_riscv(struct rte_eth_dev *dev, void *msg_req,
>  		PMD_MSG_LOG(ERR, "Failed to send sync messages or receive response");
>  		return -1;
>  	}
> -	if (reply_head->flag != ZXDH_MSG_REPS_OK) {
> -		PMD_MSG_LOG(ERR, "vf[%d] get pf reply failed: reply_head flag : 0x%x(0xff is OK).replylen %d",
> -				hw->vport.vfid, reply_head->flag, reply_head->reps_len);
> -		return -1;
> -	}
> -	if (reply_body->flag != ZXDH_REPS_SUCC) {
> -		PMD_MSG_LOG(ERR, "vf[%d] msg processing failed", hw->vfid);
> -		return -1;
> -	}
>  
>  	return 0;
>  }
> @@ -1245,7 +1235,7 @@ zxdh_vf_promisc_uninit(struct zxdh_hw *hw, union zxdh_virport_num vport)
>  
>  static int
>  zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
> +		void *res_info, uint16_t *res_len)
>  {
>  	struct zxdh_port_attr_table port_attr = {0};
>  	union zxdh_virport_num port = {.vport = vport};
> @@ -1275,14 +1265,13 @@ zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>  		PMD_DRV_LOG(ERR, "vf_promisc_table_init failed, code:%d", ret);
>  		goto proc_end;
>  	}
> -
> -	res_info->flag = ZXDH_REPS_SUCC;
> -	*res_len = sizeof(res_info->flag);
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
> +	*res_len = sizeof(uint8_t);
>  
>  	return ret;
>  proc_end:
> -	*res_len = sizeof(res_info->flag);
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	*res_len = sizeof(uint8_t);
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	return ret;
>  }
>  
> @@ -1311,11 +1300,12 @@ zxdh_mac_clear(struct zxdh_hw *hw, union zxdh_virport_num vport)
>  static int
>  zxdh_vf_port_uninit(struct zxdh_hw *pf_hw,
>  		uint16_t vport, void *cfg_data __rte_unused,
> -		struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
> +		void *res_info, uint16_t *res_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "uninit";
>  	struct zxdh_port_attr_table port_attr = {0};
>  	union zxdh_virport_num vport_num = {.vport = vport};
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, reply_data);
>  	int ret = 0;
>  
>  	*res_len =  ZXDH_MSG_REPLYBODY_HEAD;
> @@ -1340,20 +1330,20 @@ zxdh_vf_port_uninit(struct zxdh_hw *pf_hw,
>  	}
>  
>  	*res_len += strlen(str);
> -	rte_memcpy(&res_info->reply_data, str, strlen(str) + 1);
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  	return ret;
>  
>  proc_end:
>  	*res_len += strlen(str);
> -	rte_memcpy(&res_info->reply_data, str, strlen(str) + 1);
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	return ret;
>  }
>  
>  static int
>  zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *reply_body, uint16_t *reply_len)
> +		void *reply_body, uint16_t *reply_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "add mac";
>  	union zxdh_virport_num port = {0};
> @@ -1362,6 +1352,8 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  	int i = 0, ret = 0;
>  	uint16_t vf_id = port.vfid;
>  	port.vport = vport;
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body, reply_data);
> +	void *mac_reply_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body, mac_reply_msg);
>  
>  	for (i = 0; i < ZXDH_MAX_MAC_ADDRS; i++)
>  		if (rte_is_same_ether_addr(&hw->vfinfo[vf_id].vf_mac[i], addr))
> @@ -1369,7 +1361,7 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  
>  	ret = zxdh_add_mac_table(hw, vport, addr, hw->hash_search_index, 0, 0);
>  	if (ret == -EADDRINUSE) {
> -		reply_body->mac_reply_msg.mac_flag = ZXDH_EEXIST_MAC_FLAG;
> +		ZXDH_SET(mac_reply_msg, mac_reply_msg_addr, mac_flag, ZXDH_EEXIST_MAC_FLAG);
>  		PMD_DRV_LOG(ERR, "vf vport 0x%x set mac ret 0x%x failed. mac is in used.",
>  				port.vport, ret);
>  		goto failure;
> @@ -1389,26 +1381,27 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  success:
>  	sprintf(str, " vport 0x%x set mac ret 0x%x\n", port.vport, ret);
>  	*reply_len =  strlen(str) + ZXDH_MSG_REPLYBODY_HEAD;
> -	rte_memcpy(&reply_body->reply_data, str, strlen(str) + 1);
> -	reply_body->flag = ZXDH_REPS_SUCC;
> +	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
> +	ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_SUCC);
>  	PMD_DRV_LOG(DEBUG, " reply len %d", *reply_len);
>  	return ret;
>  
>  failure:
>  	*reply_len = strlen(str) + ZXDH_MSG_REPLYBODY_HEAD;
> -	reply_body->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_FAIL);
>  	return ret;
>  }
>  
>  static int
>  zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
> +	void *res_info, uint16_t *res_len)
>  {
>  	int ret, i = 0;
>  	struct zxdh_mac_filter *mac_filter = (struct zxdh_mac_filter *)cfg_data;
>  	union zxdh_virport_num  port = (union zxdh_virport_num)vport;
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "del mac";
>  	uint16_t  vf_id = port.vfid;
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, reply_data);
>  
>  	PMD_DRV_LOG(DEBUG, "[PF GET MSG FROM VF]--vf mac to del.");
>  	ret = zxdh_del_mac_table(hw, vport, &mac_filter->mac, hw->hash_search_index, 0, 0);
> @@ -1428,19 +1421,19 @@ zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  
>  	sprintf(str, "vport 0x%x del mac ret 0x%x\n", port.vport, ret);
>  	*res_len =  strlen(str) + ZXDH_MSG_REPLYBODY_HEAD;
> -	rte_memcpy(&res_info->reply_data, str, strlen(str) + 1);
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	rte_memcpy(reply_data_addr, str, strlen(str) + 1);
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  	return ret;
>  
>  proc_end:
>  	*res_len = strlen(str) + ZXDH_MSG_REPLYBODY_HEAD;
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_promisc_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +		void *reply, uint16_t *res_len)
>  {
>  	struct zxdh_port_promisc_msg *promisc_msg = (struct zxdh_port_promisc_msg *)cfg_data;
>  	int ret = 0;
> @@ -1458,24 +1451,25 @@ zxdh_vf_promisc_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  		goto proc_end;
>  	}
>  
> -	*res_len = sizeof(struct zxdh_port_attr_set_msg) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = ZXDH_REPS_SUCC;
> +	*res_len = sizeof(struct zxdh_port_attr_set_msg) + sizeof(uint8_t);
> +	ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
>  
>  	return ret;
>  
>  proc_end:
> -	*res_len = sizeof(struct zxdh_port_attr_set_msg) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = ZXDH_REPS_FAIL;
> +	*res_len = sizeof(struct zxdh_port_attr_set_msg) + sizeof(uint8_t);
> +	ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_vlan_filter_table_process(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *res_info, uint16_t *res_len, uint8_t enable)
> +		void *res_info, uint16_t *res_len, uint8_t enable)
>  {
>  	struct zxdh_vlan_filter *vlan_filter = cfg_data;
>  	uint16_t vlan_id =  vlan_filter->vlan_id;
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "vlan filter table";
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, reply_data);
>  	int ret = 0;
>  
>  	ret = zxdh_vlan_filter_table_set(hw, vport, vlan_id, enable);
> @@ -1483,33 +1477,38 @@ zxdh_vf_vlan_filter_table_process(struct zxdh_hw *hw, uint16_t vport, void *cfg_
>  		sprintf(str, "vlan filter op-code[%d] vlan id:%d failed, code:%d\n",
>  			enable, vlan_id, ret);
>  
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	memcpy(&res_info->reply_data, str, strlen(str) + 1);
> -	res_info->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_vlan_filter_table_add(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
> +		void *res_info, uint16_t *res_len)
>  {
>  	return zxdh_vf_vlan_filter_table_process(hw, vport, cfg_data, res_info, res_len, 1);
>  }
>  
>  static int
>  zxdh_vf_vlan_filter_table_del(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
> +		void *res_info, uint16_t *res_len)
>  {
>  	return zxdh_vf_vlan_filter_table_process(hw, vport, cfg_data, res_info, res_len, 0);
>  }
>  
>  static int
>  zxdh_vf_set_vlan_filter(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +		void *reply, uint16_t *res_len)
>  {
>  	struct zxdh_vlan_filter_set *vlan_filter = cfg_data;
>  	union zxdh_virport_num port = (union zxdh_virport_num)vport;
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "vlan filter";
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
>  	int ret = 0;
>  	uint16_t vfid = port.vfid;
>  
> @@ -1517,19 +1516,23 @@ zxdh_vf_set_vlan_filter(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  	if (ret)
>  		sprintf(str, "[vfid:%d] vlan filter. set failed, ret:%d\n", vfid, ret);
>  
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_set_vlan_offload(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +		void *reply, uint16_t *res_len)
>  {
>  	struct zxdh_vlan_offload *vlan_offload = cfg_data;
>  	union zxdh_virport_num port = (union zxdh_virport_num)vport;
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "vlan offload";
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
>  	int ret = 0;
>  	uint16_t vfid = port.vfid;
>  
> @@ -1540,18 +1543,23 @@ zxdh_vf_set_vlan_offload(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  	if (ret)
>  		sprintf(str, "[vfid:%d] vlan offload set failed, ret:%d\n", vfid, ret);
>  
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_rss_hf_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_unused,
> -			struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +			void *reply, uint16_t *res_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_hf";
>  	struct zxdh_port_attr_table vport_att = {0};
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
> +	void *rss_hf_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply, rss_hf_msg);
>  	int ret = 0;
>  
>  	ret = zxdh_get_port_attr(hw, vport, &vport_att);
> @@ -1561,22 +1569,26 @@ zxdh_vf_rss_hf_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_unus
>  		goto proc_end;
>  	}
>  
> -	reply->rss_hf.rss_hf = vport_att.rss_hash_factor;
> +	ZXDH_SET(rss_hf, rss_hf_msg_addr, rss_hf, vport_att.rss_hash_factor);
>  
>  proc_end:
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_rss_hf_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -			struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +			void *reply, uint16_t *res_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_hf";
>  	struct zxdh_rss_hf *rss_hf = cfg_data;
>  	struct zxdh_port_attr_table vport_att = {0};
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
>  	int ret = 0;
>  
>  	ret = zxdh_get_port_attr(hw, vport, &vport_att);
> @@ -1596,19 +1608,23 @@ zxdh_vf_rss_hf_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  	}
>  
>  proc_end:
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_rss_enable(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -			struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +			void *reply, uint16_t *res_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_enable";
>  	struct zxdh_rss_enable *rss_enable = cfg_data;
>  	struct zxdh_port_attr_table vport_att = {0};
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
>  	int ret = 0;
>  
>  	ret = zxdh_get_port_attr(hw, vport, &vport_att);
> @@ -1628,51 +1644,63 @@ zxdh_vf_rss_enable(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  	}
>  
>  proc_end:
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_rss_table_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -		struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +		void *reply, uint16_t *res_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_table";
>  	struct zxdh_rss_reta *rss_reta = cfg_data;
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
>  	int32_t ret = 0;
>  
>  	ret = zxdh_rss_table_set(hw, vport, rss_reta);
>  	if (ret)
>  		sprintf(str, "set rss reta tbl failed, code:%d", ret);
>  
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_rss_table_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_unused,
> -		struct zxdh_msg_reply_body *reply, uint16_t *res_len)
> +		void *reply, uint16_t *res_len)
>  {
>  	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_table";
> -	struct zxdh_rss_reta *rss_reta = &reply->rss_reta;
> +	void *rss_reta_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply, rss_reta_msg);
> +	struct zxdh_rss_reta *rss_reta = (struct zxdh_rss_reta *)rss_reta_msg_addr;
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply, reply_data);
>  	int ret = 0;
>  
>  	ret = zxdh_rss_table_get(hw, vport, rss_reta);
>  	if (ret)
>  		sprintf(str, "set rss reta tbl failed, code:%d", ret);
>  
> -	*res_len = strlen(str) + sizeof(enum zxdh_reps_flag);
> -	reply->flag = (ret == 0) ? ZXDH_REPS_SUCC : ZXDH_REPS_FAIL;
> -	memcpy(&reply->reply_data, str, strlen(str) + 1);
> +	*res_len = strlen(str) + sizeof(uint8_t);
> +	if (ret == 0)
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_SUCC);
> +	else
> +		ZXDH_SET(msg_reply_body, reply, flag, ZXDH_REPS_FAIL);
> +	memcpy(reply_data_addr, str, strlen(str) + 1);
>  	return ret;
>  }
>  
>  static int
>  zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
> +	void *res_info, uint16_t *res_len)
>  {
>  	RTE_ASSERT(!cfg_data || !pf_hw);
>  	if (res_info)
> @@ -1734,7 +1762,7 @@ zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>  
>  static int
>  zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
> -		void *cfg_data, struct zxdh_msg_reply_body *res_info,
> +		void *cfg_data, void *res_info,
>  		uint16_t *res_len)
>  {
>  	struct zxdh_np_stats_updata_msg *np_stats_query =
> @@ -1745,6 +1773,47 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  	uint32_t idx = 0;
>  	int ret = 0;
>  
> +	void *hw_stats_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, hw_stats);
> +	void *tx_unicast_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_unicast_pkts);
> +	void *rx_unicast_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_unicast_pkts);
> +	void *tx_unicast_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_unicast_bytes);
> +	void *rx_unicast_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_unicast_bytes);
> +	void *tx_multicast_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_multicast_pkts);
> +	void *rx_multicast_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_multicast_pkts);
> +	void *tx_multicast_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_multicast_bytes);
> +	void *rx_multicast_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_multicast_bytes);
> +	void *tx_broadcast_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_broadcast_pkts);
> +	void *tx_broadcast_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_broadcast_bytes);
> +	void *rx_broadcast_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_broadcast_pkts);
> +	void *rx_broadcast_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_broadcast_bytes);
> +	void *tx_mtu_drop_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_mtu_drop_pkts);
> +	void *tx_mtu_drop_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_mtu_drop_bytes);
> +	void *rx_mtu_drop_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_mtu_drop_pkts);
> +	void *rx_mtu_drop_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_mtu_drop_bytes);
> +	void *tx_mtr_drop_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_mtr_drop_pkts);
> +	void *tx_mtr_drop_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, tx_mtr_drop_bytes);
> +	void *rx_mtr_drop_pkts_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_mtr_drop_pkts);
> +	void *rx_mtr_drop_bytes_addr =
> +		ZXDH_ADDR_OF(hw_np_stats, hw_stats_addr, rx_mtr_drop_bytes);
>  	if (!res_len || !res_info) {
>  		PMD_DRV_LOG(ERR, "get stat invalid inparams");
>  		return -1;
> @@ -1760,8 +1829,8 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_unicast_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_unicast_bytes);
> +	zxdh_data_hi_to_lo(tx_unicast_pkts_addr);
> +	zxdh_data_hi_to_lo(tx_unicast_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_UNICAST_STATS_INGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1771,8 +1840,8 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_unicast_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_unicast_bytes);
> +	zxdh_data_hi_to_lo(rx_unicast_pkts_addr);
> +	zxdh_data_hi_to_lo(rx_unicast_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_MULTICAST_STATS_EGRESS_BASE;
>  	ret = zxdh_np_dtb_stats_get(pf_hw->dev_id, pf_hw->dev_sd->dtb_sd.queueid,
> @@ -1781,8 +1850,8 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_multicast_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_multicast_bytes);
> +	zxdh_data_hi_to_lo(tx_multicast_pkts_addr);
> +	zxdh_data_hi_to_lo(tx_multicast_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_MULTICAST_STATS_INGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1792,8 +1861,8 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_multicast_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_multicast_bytes);
> +	zxdh_data_hi_to_lo(rx_multicast_pkts_addr);
> +	zxdh_data_hi_to_lo(rx_multicast_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_BROAD_STATS_EGRESS_BASE;
>  	ret = zxdh_np_dtb_stats_get(pf_hw->dev_id, pf_hw->dev_sd->dtb_sd.queueid,
> @@ -1802,8 +1871,8 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_broadcast_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_broadcast_bytes);
> +	zxdh_data_hi_to_lo(tx_broadcast_pkts_addr);
> +	zxdh_data_hi_to_lo(tx_broadcast_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_BROAD_STATS_INGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1813,8 +1882,8 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_broadcast_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_broadcast_bytes);
> +	zxdh_data_hi_to_lo(rx_broadcast_pkts_addr);
> +	zxdh_data_hi_to_lo(rx_broadcast_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_MTU_STATS_EGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1824,10 +1893,10 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	res_info->np_stats.tx_mtu_drop_pkts = stats_data.n_pkts_dropped;
> -	res_info->np_stats.tx_mtu_drop_bytes = stats_data.n_bytes_dropped;
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtu_drop_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtu_drop_bytes);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, tx_mtu_drop_pkts, stats_data.n_pkts_dropped);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, tx_mtu_drop_bytes, stats_data.n_bytes_dropped);
> +	zxdh_data_hi_to_lo(tx_mtu_drop_pkts_addr);
> +	zxdh_data_hi_to_lo(tx_mtu_drop_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_MTU_STATS_INGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1837,10 +1906,10 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	res_info->np_stats.rx_mtu_drop_pkts = stats_data.n_pkts_dropped;
> -	res_info->np_stats.rx_mtu_drop_bytes = stats_data.n_bytes_dropped;
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtu_drop_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtu_drop_bytes);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, rx_mtu_drop_pkts, stats_data.n_pkts_dropped);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, rx_mtu_drop_bytes, stats_data.n_bytes_dropped);
> +	zxdh_data_hi_to_lo(rx_mtu_drop_pkts_addr);
> +	zxdh_data_hi_to_lo(rx_mtu_drop_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_MTR_STATS_EGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1850,10 +1919,11 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	res_info->np_stats.tx_mtr_drop_pkts = stats_data.n_pkts_dropped;
> -	res_info->np_stats.tx_mtr_drop_bytes = stats_data.n_bytes_dropped;
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtr_drop_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.tx_mtr_drop_bytes);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, tx_mtr_drop_pkts, stats_data.n_pkts_dropped);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, tx_mtr_drop_bytes, stats_data.n_bytes_dropped);
> +
> +	zxdh_data_hi_to_lo(tx_mtr_drop_pkts_addr);
> +	zxdh_data_hi_to_lo(tx_mtr_drop_bytes_addr);
>  
>  	idx = zxdh_vport_to_vfid(vport_num) + ZXDH_MTR_STATS_INGRESS_BASE;
>  	memset(&stats_data, 0, sizeof(stats_data));
> @@ -1863,10 +1933,11 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  		PMD_DRV_LOG(ERR, "get stats failed. code:%d", ret);
>  		return ret;
>  	}
> -	res_info->np_stats.rx_mtr_drop_pkts = stats_data.n_pkts_dropped;
> -	res_info->np_stats.rx_mtr_drop_bytes = stats_data.n_bytes_dropped;
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtr_drop_pkts);
> -	zxdh_data_hi_to_lo(&res_info->np_stats.rx_mtr_drop_bytes);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, rx_mtr_drop_pkts, stats_data.n_pkts_dropped);
> +	ZXDH_SET(hw_np_stats, hw_stats_addr, rx_mtr_drop_bytes, stats_data.n_bytes_dropped);
> +
> +	zxdh_data_hi_to_lo(rx_mtr_drop_pkts_addr);
> +	zxdh_data_hi_to_lo(rx_mtr_drop_bytes_addr);
>  	*res_len = sizeof(struct zxdh_hw_np_stats);
>  
>  	return 0;
> @@ -1875,12 +1946,13 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  static int
>  zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw,
>  	uint16_t vport, void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info,
> +	void *res_info,
>  	uint16_t *res_len)
>  {
>  	struct zxdh_mtr_stats_query  *zxdh_mtr_stats_query =
>  			(struct zxdh_mtr_stats_query  *)cfg_data;
>  	union zxdh_virport_num v_port = {.vport = vport};
> +	uint8_t *hw_mtr_stats_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, hw_mtr_stats);
>  	int ret = 0;
>  
>  	uint32_t stat_baseaddr = zxdh_mtr_stats_query->direction ==
> @@ -1892,14 +1964,14 @@ zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw,
>  		PMD_DRV_LOG(ERR, "get stat invalid in params");
>  		return -1;
>  	}
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	ret = zxdh_np_dtb_stats_get(pf_hw->dev_id, pf_hw->dev_sd->dtb_sd.queueid,
> -				1, idx, (uint32_t *)&res_info->hw_mtr_stats);
> +				1, idx, (uint32_t *)hw_mtr_stats_addr);
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "get dir %d stats  failed", zxdh_mtr_stats_query->direction);
>  		return ret;
>  	}
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  	*res_len = sizeof(struct zxdh_hw_mtr_stats);
>  	return 0;
>  }
> @@ -1908,7 +1980,7 @@ static int
>  zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw,
>  	uint16_t vport,
>  	void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info,
> +	void *res_info,
>  	uint16_t *res_len)
>  {
>  	if (!cfg_data || !res_len || !res_info) {
> @@ -1917,16 +1989,18 @@ zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw,
>  	}
>  	struct rte_mtr_error error = {0};
>  	int ret = 0;
> -	uint64_t profile_id = HW_PROFILE_MAX;
> +	uint64_t hw_profile_id = HW_PROFILE_MAX;
> +	void *mtr_profile_info_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, mtr_profile_info);
>  
>  	struct zxdh_plcr_profile_add  *zxdh_plcr_profile_add =
>  		(struct zxdh_plcr_profile_add *)cfg_data;
>  
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
> +
>  	*res_len = sizeof(struct zxdh_mtr_profile_info);
>  	ret = zxdh_hw_profile_alloc_direct(pf_hw->eth_dev,
>  		zxdh_plcr_profile_add->car_type,
> -		&profile_id, &error);
> +		&hw_profile_id, &error);
>  
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "pf 0x%x for vf 0x%x alloc hw profile failed",
> @@ -1935,9 +2009,9 @@ zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw,
>  		);
>  		return -1;
>  	}
> -	zxdh_hw_profile_ref(profile_id);
> -	res_info->mtr_profile_info.profile_id = profile_id;
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	zxdh_hw_profile_ref(hw_profile_id);
> +	ZXDH_SET(mtr_profile_info, mtr_profile_info_addr, profile_id, hw_profile_id);
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  
>  	return 0;
>  }
> @@ -1946,7 +2020,7 @@ static int
>  zxdh_vf_mtr_hw_profile_del(struct zxdh_hw *pf_hw,
>  	uint16_t vport,
>  	void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info,
> +	void *res_info,
>  	uint16_t *res_len)
>  {
>  	if (!cfg_data || !res_len || !res_info) {
> @@ -1954,7 +2028,7 @@ zxdh_vf_mtr_hw_profile_del(struct zxdh_hw *pf_hw,
>  		return -1;
>  	}
>  
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	*res_len = 0;
>  	struct zxdh_plcr_profile_free *mtr_profile_free = (struct zxdh_plcr_profile_free *)cfg_data;
>  	uint64_t profile_id = mtr_profile_free->profile_id;
> @@ -1980,7 +2054,7 @@ zxdh_vf_mtr_hw_profile_del(struct zxdh_hw *pf_hw,
>  				RTE_MTR_ERROR_TYPE_METER_PROFILE_ID, NULL,
>  				"Meter offload del profile failed ");
>  	}
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  	return 0;
>  }
>  
> @@ -1988,7 +2062,7 @@ static int
>  zxdh_vf_mtr_hw_plcrflow_cfg(struct zxdh_hw *pf_hw,
>  	uint16_t vport,
>  	void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info,
> +	void *res_info,
>  	uint16_t *res_len)
>  {
>  	int ret = 0;
> @@ -2000,7 +2074,7 @@ zxdh_vf_mtr_hw_plcrflow_cfg(struct zxdh_hw *pf_hw,
>  	struct rte_mtr_error error = {0};
>  	struct zxdh_plcr_flow_cfg *zxdh_plcr_flow_cfg = (struct zxdh_plcr_flow_cfg *)cfg_data;
>  
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	*res_len = 0;
>  	ret = zxdh_np_stat_car_queue_cfg_set(pf_hw->dev_id,
>  		zxdh_plcr_flow_cfg->car_type,
> @@ -2019,7 +2093,7 @@ zxdh_vf_mtr_hw_plcrflow_cfg(struct zxdh_hw *pf_hw,
>  				RTE_MTR_ERROR_TYPE_MTR_PARAMS,
>  				NULL, "Failed to bind plcr flow.");
>  	}
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  	return 0;
>  }
>  
> @@ -2027,7 +2101,7 @@ static int
>  zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw __rte_unused,
>  	uint16_t vport,
>  	void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info,
> +	void *res_info,
>  	uint16_t *res_len)
>  {
>  	int ret = 0;
> @@ -2036,14 +2110,15 @@ zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw __rte_unused,
>  		PMD_DRV_LOG(ERR, " cfg profile invalid inparams");
>  		return -1;
>  	}
> -	res_info->flag = ZXDH_REPS_FAIL;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
>  	*res_len = 0;
>  	struct rte_mtr_error error = {0};
>  	struct zxdh_plcr_profile_cfg *zxdh_plcr_profile_cfg =
>  		(struct zxdh_plcr_profile_cfg *)cfg_data;
>  	union zxdh_offload_profile_cfg *plcr_param = &zxdh_plcr_profile_cfg->plcr_param;
>  
> -	ret = zxdh_np_car_profile_cfg_set(vport,
> +	ret = zxdh_np_car_profile_cfg_set(pf_hw->dev_id,
> +		vport,
>  		zxdh_plcr_profile_cfg->car_type,
>  		zxdh_plcr_profile_cfg->packet_mode,
>  		zxdh_plcr_profile_cfg->hw_profile_id,
> @@ -2052,7 +2127,7 @@ zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw __rte_unused,
>  		PMD_DRV_LOG(ERR, "(vport %d)config hw profilefailed", vport);
>  		return -rte_mtr_error_set(&error, ENOTSUP, RTE_MTR_ERROR_TYPE_METER_PROFILE, NULL, "Meter offload cfg profile failed");
>  	}
> -	res_info->flag = ZXDH_REPS_SUCC;
> +	ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>  	return 0;
>  }
>  
> @@ -2083,7 +2158,7 @@ static const zxdh_msg_process_callback zxdh_proc_cb[] = {
>  
>  static inline int
>  zxdh_config_process_callback(struct zxdh_hw *hw, struct zxdh_msg_info *msg_info,
> -	struct zxdh_msg_reply_body *res, uint16_t *res_len)
> +	void *res, uint16_t *res_len)
>  {
>  	struct zxdh_msg_head *msghead = &msg_info->msg_head;
>  	int ret = -1;
> @@ -2096,13 +2171,13 @@ zxdh_config_process_callback(struct zxdh_hw *hw, struct zxdh_msg_info *msg_info,
>  		ret = zxdh_proc_cb[msghead->msg_type](hw, msghead->vport,
>  					(void *)&msg_info->data, res, res_len);
>  		if (!ret)
> -			res->flag = ZXDH_REPS_SUCC;
> +			ZXDH_SET(msg_reply_body, res, flag, ZXDH_REPS_SUCC);
>  		else
> -			res->flag = ZXDH_REPS_FAIL;
> +			ZXDH_SET(msg_reply_body, res, flag, ZXDH_REPS_FAIL);
>  	} else {
> -		res->flag = ZXDH_REPS_INVALID;
> +		ZXDH_SET(msg_reply_body, res, flag, ZXDH_REPS_INVALID);
>  	}
> -	*res_len += sizeof(res->flag);
> +	*res_len += sizeof(uint8_t);
>  	return ret;
>  }
>  
> @@ -2111,7 +2186,7 @@ pf_recv_bar_msg(void *pay_load, uint16_t len, void *reps_buffer,
>  	uint16_t *reps_len, void *eth_dev)
>  {
>  	struct zxdh_msg_info *msg_info = (struct zxdh_msg_info *)pay_load;
> -	struct zxdh_msg_reply_body *reply_body = reps_buffer;
> +	void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reps_buffer, reply_data);
>  	struct rte_eth_dev *dev = (struct rte_eth_dev *)eth_dev;
>  	int32_t ret = 0;
>  	struct zxdh_hw *hw;
> @@ -2131,14 +2206,14 @@ pf_recv_bar_msg(void *pay_load, uint16_t len, void *reps_buffer,
>  		goto msg_proc_end;
>  	}
>  
> -	ret = zxdh_config_process_callback(hw, msg_info, reply_body, &reply_len);
> -	*reps_len = reply_len + sizeof(struct zxdh_msg_reply_head);
> +	ret = zxdh_config_process_callback(hw, msg_info, reps_buffer, &reply_len);
> +	*reps_len = reply_len + ZXDH_ST_SZ_BYTES(msg_reply_head);
>  	return ret;
>  
>  msg_proc_end:
> -	memcpy(reply_body->reply_data, &ret, sizeof(ret));
> +	memcpy(reply_data_addr, &ret, sizeof(ret));
>  	reply_len = sizeof(ret);
> -	*reps_len = sizeof(struct zxdh_msg_reply_head) + reply_len;
> +	*reps_len = ZXDH_ST_SZ_BYTES(msg_reply_head) + reply_len;
>  	return ret;
>  }
>  
> diff --git a/drivers/net/zxdh/zxdh_msg.h b/drivers/net/zxdh/zxdh_msg.h
> index 58836bb4b7..7dad6f7335 100644
> --- a/drivers/net/zxdh/zxdh_msg.h
> +++ b/drivers/net/zxdh/zxdh_msg.h
> @@ -11,6 +11,7 @@
>  
>  #include "zxdh_ethdev_ops.h"
>  #include "zxdh_mtr.h"
> +#include "zxdh_common.h"
>  
>  #define ZXDH_BAR0_INDEX                 0
>  #define ZXDH_CTRLCH_OFFSET              (0x2000)
> @@ -46,8 +47,10 @@
>  
>  #define ZXDH_MSG_REPLYBODY_HEAD    sizeof(enum zxdh_reps_flag)
>  #define ZXDH_MSG_HEADER_SIZE       4
> -#define ZXDH_MSG_REPLY_BODY_MAX_LEN  \
> -		(ZXDH_MSG_PAYLOAD_MAX_LEN - sizeof(struct zxdh_msg_reply_head))
> +#define ZXDH_MSG_REPLY_BODY_MAX_LEN \
> +		(ZXDH_MSG_PAYLOAD_MAX_LEN - ZXDH_MSG_HEADER_SIZE)
> +#define ZXDH_MSG_REPLY_DATA \
> +		(ZXDH_MSG_REPLY_BODY_MAX_LEN - ZXDH_MSG_REPLYBODY_HEAD)
>  
>  #define ZXDH_MSG_HEAD_LEN            8
>  #define ZXDH_MSG_REQ_BODY_MAX_LEN  \
> @@ -329,12 +332,6 @@ struct zxdh_offset_get_msg {
>  	uint16_t type;
>  };
>  
> -struct zxdh_msg_reply_head {
> -	uint8_t flag;
> -	uint16_t reps_len;
> -	uint8_t resvd;
> -};
> -
>  enum zxdh_reps_flag {
>  	ZXDH_REPS_FAIL,
>  	ZXDH_REPS_SUCC = 0xaa,
> @@ -354,18 +351,39 @@ struct zxdh_link_info_msg {
>  	uint32_t speed;
>  };
>  
> +struct zxdh_ifc_link_info_msg_bits {
> +	uint8_t autoneg[0x8];
> +	uint8_t link_state[0x8];
> +	uint8_t blink_enable[0x8];
> +	uint8_t duplex[0x8];
> +	uint8_t speed_modes[0x20];
> +	uint8_t speed[0x20];
> +};
> +
>  struct zxdh_rss_reta {
>  	uint32_t reta[RTE_ETH_RSS_RETA_SIZE_256];
>  };
>  
> +struct zxdh_ifc_rss_reta_bits {
> +	uint32_t reta[RTE_ETH_RSS_RETA_SIZE_256 * 8];
> +};
> +
>  struct zxdh_rss_hf {
>  	uint32_t rss_hf;
>  };
>  
> +struct zxdh_ifc_rss_hf_bits {
> +	uint8_t rss_hf[0x20];
> +};
> +
>  struct zxdh_mac_reply_msg {
>  	uint8_t mac_flag;
>  };
>  
> +struct zxdh_ifc_mac_reply_msg_bits {
> +	uint8_t mac_flag[0x8];
> +};
> +
>  struct zxdh_mac_module_eeprom_msg {
>  	uint8_t i2c_addr;
>  	uint8_t bank;
> @@ -375,34 +393,57 @@ struct zxdh_mac_module_eeprom_msg {
>  	uint8_t data[ZXDH_MODULE_EEPROM_DATA_LEN];
>  };
>  
> +struct zxdh_ifc_agent_mac_module_eeprom_msg_bits {
> +	uint8_t i2c_addr[0x8];
> +	uint8_t bank[0x8];
> +	uint8_t page[0x8];
> +	uint8_t offset[0x8];
> +	uint8_t length[0x8];
> +	uint8_t data[ZXDH_MODULE_EEPROM_DATA_LEN * 8];
> +};
> +
>  struct zxdh_flash_msg {
>  	uint8_t firmware_version[ZXDH_FWVERS_LEN];
>  };
>  
> +struct zxdh_ifc_agent_flash_msg_bits {
> +	uint8_t firmware_version[0x100];
> +};
> +
>  struct zxdh_mtr_profile_info {
>  	uint64_t profile_id;
>  };
>  
> -struct zxdh_msg_reply_body {
> -	enum zxdh_reps_flag flag;
> +struct zxdh_ifc_mtr_profile_info_bits {
> +	uint8_t profile_id[0x40];
> +};
> +
> +struct zxdh_ifc_msg_reply_body_bits {
> +	uint8_t flag[0x8];
>  	union {
> -		uint8_t reply_data[ZXDH_MSG_REPLY_BODY_MAX_LEN - sizeof(enum zxdh_reps_flag)];
> -		struct zxdh_hw_np_stats np_stats;
> -		struct zxdh_link_info_msg link_msg;
> -		struct zxdh_rss_reta rss_reta;
> -		struct zxdh_rss_hf rss_hf;
> -		struct zxdh_hw_vqm_stats vqm_stats;
> -		struct zxdh_mac_reply_msg mac_reply_msg;
> -		struct zxdh_flash_msg flash_msg;
> -		struct zxdh_mac_module_eeprom_msg module_eeprom_msg;
> -		struct zxdh_mtr_profile_info mtr_profile_info;
> -		struct zxdh_mtr_stats hw_mtr_stats;
> +		uint8_t reply_data[ZXDH_MSG_REPLY_DATA * 8];
> +		struct zxdh_ifc_hw_np_stats_bits hw_stats;
> +		struct zxdh_ifc_link_info_msg_bits link_msg;
> +		struct zxdh_ifc_rss_reta_bits rss_reta_msg;
> +		struct zxdh_ifc_rss_hf_bits rss_hf_msg;
> +		struct zxdh_ifc_hw_vqm_stats_bits vqm_stats;
> +		struct zxdh_ifc_mac_reply_msg_bits mac_reply_msg;
> +		struct zxdh_ifc_agent_flash_msg_bits flash_msg;
> +		struct zxdh_ifc_agent_mac_module_eeprom_msg_bits module_eeprom_msg;
> +		struct zxdh_ifc_mtr_profile_info_bits  mtr_profile_info;
> +		struct zxdh_ifc_mtr_stats_bits hw_mtr_stats;
>  	};
>  };
>  
> -struct zxdh_msg_reply_info {
> -	struct zxdh_msg_reply_head reply_head;
> -	struct zxdh_msg_reply_body reply_body;
> +struct zxdh_ifc_msg_reply_head_bits {
> +	uint8_t flag[0x8];
> +	uint8_t reps_len[0x10];
> +	uint8_t resvd[0x8];
> +};
> +
> +struct zxdh_ifc_msg_reply_info_bits {
> +	struct zxdh_ifc_msg_reply_head_bits reply_head;
> +	struct zxdh_ifc_msg_reply_body_bits reply_body;
>  };
>  
>  struct zxdh_vf_init_msg {
> @@ -412,12 +453,12 @@ struct zxdh_vf_init_msg {
>  	uint8_t rss_enable;
>  };
>  
> -struct zxdh_msg_head {
> -	enum zxdh_msg_type msg_type;
> +struct __rte_packed_begin zxdh_msg_head {
> +	uint8_t msg_type;
>  	uint16_t  vport;
>  	uint16_t  vf_id;
>  	uint16_t pcieid;
> -};
> +} __rte_packed_end;
>  
>  struct zxdh_port_attr_set_msg {
>  	uint32_t mode;
> @@ -455,7 +496,7 @@ struct zxdh_rss_enable {
>  };
>  
>  struct zxdh_agent_msg_head {
> -	enum zxdh_agent_msg_type msg_type;
> +	uint8_t msg_type;
>  	uint8_t panel_id;
>  	uint8_t phyport;
>  	uint8_t rsv;
> @@ -526,7 +567,7 @@ struct zxdh_msg_info {
>  typedef int (*zxdh_bar_chan_msg_recv_callback)(void *pay_load, uint16_t len,
>  		void *reps_buffer, uint16_t *reps_len, void *dev);
>  typedef int (*zxdh_msg_process_callback)(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -	struct zxdh_msg_reply_body *res_info, uint16_t *res_len);
> +	void *res_info, uint16_t *res_len);
>  
>  typedef int (*zxdh_bar_chan_msg_recv_callback)(void *pay_load, uint16_t len,
>  			void *reps_buffer, uint16_t *reps_len, void *dev);
> diff --git a/drivers/net/zxdh/zxdh_mtr.c b/drivers/net/zxdh/zxdh_mtr.c
> index 3797a5b29b..b23f6535a8 100644
> --- a/drivers/net/zxdh/zxdh_mtr.c
> +++ b/drivers/net/zxdh/zxdh_mtr.c
> @@ -281,7 +281,7 @@ zxdh_hw_profile_free_direct(struct rte_eth_dev *dev, ZXDH_PROFILE_TYPE car_type,
>  {
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	uint16_t vport = hw->vport.vport;
> -	int ret = zxdh_np_car_profile_id_delete(vport, car_type,
> +	int ret = zxdh_np_car_profile_id_delete(hw->dev_id, vport, car_type,
>  			(uint64_t)hw_profile_id);
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "port %u free hw profile %u failed", vport, hw_profile_id);
> @@ -299,7 +299,7 @@ zxdh_hw_profile_alloc_direct(struct rte_eth_dev *dev, ZXDH_PROFILE_TYPE car_type
>  	uint64_t profile_id = HW_PROFILE_MAX;
>  	struct zxdh_hw *hw = dev->data->dev_private;
>  	uint16_t vport = hw->vport.vport;
> -	int ret = zxdh_np_car_profile_id_add(vport, car_type, &profile_id);
> +	int ret = zxdh_np_car_profile_id_add(hw->dev_id, vport, car_type, &profile_id);
>  
>  	if (ret) {
>  		PMD_DRV_LOG(ERR, "port %u alloc hw profile failed", vport);
> @@ -326,7 +326,7 @@ zxdh_hw_profile_free(struct rte_eth_dev *dev, uint8_t car_type,
>  		ret = zxdh_hw_profile_free_direct(dev, car_type, (uint64_t)hw_profile_id, error);
>  	} else {
>  		struct zxdh_msg_info msg_info = {0};
> -		struct zxdh_msg_reply_info reply_info = {0};
> +		uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  		struct zxdh_plcr_profile_free *zxdh_plcr_profile_free =
>  			&msg_info.data.zxdh_plcr_profile_free;
>  
> @@ -335,7 +335,7 @@ zxdh_hw_profile_free(struct rte_eth_dev *dev, uint8_t car_type,
>  		zxdh_msg_head_build(hw, ZXDH_PLCR_CAR_PROFILE_ID_DELETE, &msg_info);
>  		ret = zxdh_vf_send_msg_to_pf(dev, &msg_info,
>  			ZXDH_MSG_HEAD_LEN + sizeof(struct zxdh_plcr_profile_free),
> -			&reply_info, sizeof(struct zxdh_msg_reply_info));
> +			zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
>  
>  		if (ret)
>  			return -rte_mtr_error_set(error, ENOTSUP,
> @@ -357,15 +357,19 @@ zxdh_hw_profile_alloc(struct rte_eth_dev *dev, uint64_t *hw_profile_id,
>  		ret = zxdh_hw_profile_alloc_direct(dev, CAR_A, hw_profile_id, error);
>  	} else {
>  		struct zxdh_msg_info msg_info = {0};
> -		struct zxdh_msg_reply_info reply_info = {0};
> +		uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  		struct zxdh_plcr_profile_add  *zxdh_plcr_profile_add =
>  			&msg_info.data.zxdh_plcr_profile_add;
> +		void *reply_body_addr =
> +			ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +		void *mtr_profile_info_addr =
> +			ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, mtr_profile_info);
>  
>  		zxdh_plcr_profile_add->car_type = CAR_A;
>  		zxdh_msg_head_build(hw, ZXDH_PLCR_CAR_PROFILE_ID_ADD, &msg_info);
>  		ret = zxdh_vf_send_msg_to_pf(dev, &msg_info,
>  			ZXDH_MSG_HEAD_LEN + sizeof(struct zxdh_plcr_profile_add),
> -			&reply_info, sizeof(struct zxdh_msg_reply_info));
> +			zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
>  
>  		if (ret) {
>  			PMD_DRV_LOG(ERR,
> @@ -376,7 +380,7 @@ zxdh_hw_profile_alloc(struct rte_eth_dev *dev, uint64_t *hw_profile_id,
>  					RTE_MTR_ERROR_TYPE_METER_PROFILE_ID, NULL,
>  					"Meter offload alloc profile  id msg failed ");
>  		}
> -		*hw_profile_id = reply_info.reply_body.mtr_profile_info.profile_id;
> +		*hw_profile_id = ZXDH_GET(mtr_profile_info, mtr_profile_info_addr, profile_id);
>  		if (*hw_profile_id == ZXDH_HW_PROFILE_MAX) {
>  			return -rte_mtr_error_set(error, ENOTSUP,
>  					RTE_MTR_ERROR_TYPE_METER_PROFILE_ID, NULL,
> @@ -432,7 +436,7 @@ zxdh_mtr_hw_counter_query(struct rte_eth_dev *dev,
>  		}
>  	} else { /* send msg to pf */
>  		struct zxdh_msg_info msg_info = {0};
> -		struct zxdh_msg_reply_info reply_info = {0};
> +		uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  		struct zxdh_mtr_stats_query *zxdh_mtr_stats_query =
>  				&msg_info.data.zxdh_mtr_stats_query;
>  
> @@ -442,8 +446,8 @@ zxdh_mtr_hw_counter_query(struct rte_eth_dev *dev,
>  		ret = zxdh_vf_send_msg_to_pf(dev,
>  			&msg_info,
>  			sizeof(msg_info),
> -			&reply_info,
> -			sizeof(struct zxdh_msg_reply_info));
> +			zxdh_msg_reply_info,
> +			ZXDH_ST_SZ_BYTES(msg_reply_info));
>  
>  		if (ret) {
>  			PMD_DRV_LOG(ERR,
> @@ -451,7 +455,11 @@ zxdh_mtr_hw_counter_query(struct rte_eth_dev *dev,
>  				hw->vport.vport);
>  			return -rte_mtr_error_set(error, ENOTSUP, RTE_MTR_ERROR_TYPE_STATS, NULL, "Meter offload alloc profile failed");
>  		}
> -		struct zxdh_mtr_stats *hw_mtr_stats = &reply_info.reply_body.hw_mtr_stats;
> +		void *reply_body_addr =
> +			ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +		void *hw_mtr_stats_addr =
> +			ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, hw_mtr_stats);
> +		struct zxdh_mtr_stats *hw_mtr_stats = (struct zxdh_mtr_stats *)hw_mtr_stats_addr;
>  
>  		mtr_stats->n_bytes_dropped = hw_mtr_stats->n_bytes_dropped;
>  		mtr_stats->n_pkts_dropped = hw_mtr_stats->n_pkts_dropped;
> @@ -551,7 +559,9 @@ zxdh_hw_profile_config_direct(struct rte_eth_dev *dev __rte_unused,
>  	struct zxdh_meter_profile *mp,
>  	struct rte_mtr_error *error)
>  {
> -	int ret = zxdh_np_car_profile_cfg_set(mp->hw_profile_owner_vport,
> +	struct zxdh_hw *hw = dev->data->dev_private;
> +	int ret = zxdh_np_car_profile_cfg_set(hw->dev_id,
> +		mp->hw_profile_owner_vport,
>  		car_type, mp->profile.packet_mode,
>  		(uint32_t)hw_profile_id, &mp->plcr_param);
>  	if (ret) {
> @@ -573,7 +583,7 @@ static int zxdh_hw_profile_config(struct rte_eth_dev *dev, uint16_t hw_profile_i
>  		ret = zxdh_hw_profile_config_direct(dev, CAR_A, hw_profile_id, mp, error);
>  	} else {
>  		struct zxdh_msg_info msg_info = {0};
> -		struct zxdh_msg_reply_info reply_info = {0};
> +		uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  		struct zxdh_plcr_profile_cfg *zxdh_plcr_profile_cfg =
>  			&msg_info.data.zxdh_plcr_profile_cfg;
>  
> @@ -588,9 +598,9 @@ static int zxdh_hw_profile_config(struct rte_eth_dev *dev, uint16_t hw_profile_i
>  		ret = zxdh_vf_send_msg_to_pf(dev,
>  			&msg_info,
>  			ZXDH_MSG_HEAD_LEN + sizeof(struct zxdh_plcr_profile_cfg),
> -			&reply_info,
> -			sizeof(struct zxdh_msg_reply_info));
> -
> +			zxdh_msg_reply_info,
> +			ZXDH_ST_SZ_BYTES(msg_reply_info)
> +		);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR,
>  				"Failed msg: port 0x%x msg type ZXDH_PLCR_CAR_PROFILE_CFG_SET ",
> @@ -874,7 +884,7 @@ zxdh_set_mtr_enable(struct rte_eth_dev *dev, uint8_t dir, bool enable, struct rt
>  
>  	if (priv->is_pf) {
>  		ret = zxdh_get_port_attr(priv, priv->vport.vport, &port_attr);
> -		port_attr.ingress_meter_enable = enable;
> +		port_attr.egress_meter_enable = enable;
>  		ret = zxdh_set_port_attr(priv, priv->vport.vport, &port_attr);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "%s set port attr failed", __func__);
> @@ -936,7 +946,7 @@ zxdh_hw_plcrflow_config(struct rte_eth_dev *dev, uint16_t hw_flow_id,
>  		}
>  	} else {
>  		struct zxdh_msg_info msg_info = {0};
> -		struct zxdh_msg_reply_info reply_info = {0};
> +		uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
>  		struct zxdh_plcr_flow_cfg *zxdh_plcr_flow_cfg = &msg_info.data.zxdh_plcr_flow_cfg;
>  
>  		zxdh_plcr_flow_cfg->car_type = CAR_A;
> @@ -947,8 +957,8 @@ zxdh_hw_plcrflow_config(struct rte_eth_dev *dev, uint16_t hw_flow_id,
>  		zxdh_msg_head_build(hw, ZXDH_PLCR_CAR_QUEUE_CFG_SET, &msg_info);
>  		ret = zxdh_vf_send_msg_to_pf(dev, &msg_info,
>  			ZXDH_MSG_HEAD_LEN + sizeof(struct zxdh_plcr_flow_cfg),
> -			&reply_info,
> -			sizeof(struct zxdh_msg_reply_info));
> +			zxdh_msg_reply_info,
> +			ZXDH_ST_SZ_BYTES(msg_reply_info));
>  		if (ret) {
>  			PMD_DRV_LOG(ERR,
>  				"Failed msg: port 0x%x msg type ZXDH_PLCR_CAR_QUEUE_CFG_SET ",
> diff --git a/drivers/net/zxdh/zxdh_mtr.h b/drivers/net/zxdh/zxdh_mtr.h
> index 749ceb7479..3efcb6b591 100644
> --- a/drivers/net/zxdh/zxdh_mtr.h
> +++ b/drivers/net/zxdh/zxdh_mtr.h
> @@ -93,6 +93,11 @@ struct zxdh_mtr_stats {
>  	uint64_t n_bytes_dropped;
>  };
>  
> +struct zxdh_ifc_mtr_stats_bits {
> +	uint8_t n_pkts_dropped[0x40];
> +	uint8_t n_bytes_dropped[0x40];
> +};
> +
>  struct zxdh_hw_mtr_stats {
>  	uint32_t n_pkts_dropped_hi;
>  	uint32_t n_pkts_dropped_lo;
> diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
> index ab8b3ae688..66902e7e92 100644
> --- a/drivers/net/zxdh/zxdh_np.c
> +++ b/drivers/net/zxdh/zxdh_np.c
> @@ -2350,6 +2350,8 @@ zxdh_np_dev_add(uint32_t  dev_id, ZXDH_DEV_TYPE_E dev_type,
>  
>  	rte_spinlock_init(&p_dev_info->dtb_spinlock.spinlock);
>  
> +	rte_spinlock_init(&p_dev_info->smmu0_spinlock.spinlock);
> +
>  	for (i = 0; i < ZXDH_DTB_QUEUE_NUM_MAX; i++)
>  		rte_spinlock_init(&p_dev_info->dtb_queue_spinlock[i].spinlock);
>  
> @@ -3391,6 +3393,32 @@ zxdh_np_reg_read(uint32_t dev_id, uint32_t reg_no,
>  	return rc;
>  }
>  
> +static uint32_t
> +zxdh_np_reg_read32(uint32_t dev_id, uint32_t reg_no,
> +	uint32_t m_offset, uint32_t n_offset, uint32_t *p_data)
> +{
> +	uint32_t rc = 0;
> +	uint32_t addr = 0;
> +	ZXDH_REG_T *p_reg_info = &g_dpp_reg_info[reg_no];
> +	uint32_t p_buff[ZXDH_REG_DATA_MAX] = {0};
> +	uint32_t reg_real_no = p_reg_info->reg_no;
> +	uint32_t reg_type = p_reg_info->flags;
> +	uint32_t reg_module = p_reg_info->module_no;
> +
> +	addr = zxdh_np_reg_get_reg_addr(reg_no, m_offset, n_offset);
> +
> +	if (reg_module == DTB4K) {
> +		rc = p_reg_info->p_read_fun(dev_id, addr, p_data);
> +		ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "p_reg_info->p_read_fun");
> +	} else {
> +		rc = zxdh_np_agent_channel_reg_read(dev_id, reg_type, reg_real_no, 4, addr, p_buff);
> +		ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_agent_channel_reg_read");
> +		*p_data = p_buff[0];
> +	}
> +
> +	return rc;
> +}
> +
>  static uint32_t
>  zxdh_np_dtb_queue_vm_info_get(uint32_t dev_id,
>  		uint32_t queue_id,
> @@ -10542,9 +10570,9 @@ zxdh_np_se_done_status_check(uint32_t dev_id, uint32_t reg_no, uint32_t pos)
>  	uint32_t done_flag = 0;
>  
>  	while (!done_flag) {
> -		rc = zxdh_np_reg_read(dev_id, reg_no, 0, 0, &data);
> +		rc = zxdh_np_reg_read32(dev_id, reg_no, 0, 0, &data);
>  		if (rc != 0) {
> -			PMD_DRV_LOG(ERR, "reg_read fail!");
> +			PMD_DRV_LOG(ERR, "reg_read32 fail!");
>  			return rc;
>  		}
>  
> @@ -10577,10 +10605,17 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  	uint32_t temp_data[4] = {0};
>  	uint32_t *p_temp_data = NULL;
>  	ZXDH_SMMU0_SMMU0_CPU_IND_CMD_T cpu_ind_cmd = {0};
> +	ZXDH_SPINLOCK_T *p_ind_spinlock = NULL;
> +
> +	rc = zxdh_np_dev_opr_spinlock_get(dev_id, ZXDH_DEV_SPINLOCK_T_SMMU0, &p_ind_spinlock);
> +	ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_dev_opr_spinlock_get");
> +
> +	rte_spinlock_lock(&p_ind_spinlock->spinlock);
>  
>  	rc = zxdh_np_se_done_status_check(dev_id, ZXDH_SMMU0_SMMU0_WR_ARB_CPU_RDYR, 0);
>  	if (rc != ZXDH_OK) {
>  		PMD_DRV_LOG(ERR, "se done status check failed, rc=0x%x.", rc);
> +		rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  		return ZXDH_ERR;
>  	}
>  
> @@ -10592,11 +10627,13 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		switch (rd_mode) {
>  		case ZXDH_ERAM128_OPR_128b:
>  			if ((0xFFFFFFFF - (base_addr)) < (index)) {
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				PMD_DRV_LOG(ERR, "index 0x%x is invalid!", index);
>  				return ZXDH_PAR_CHK_INVALID_INDEX;
>  			}
>  			if (base_addr + index > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = (index << 7) & ZXDH_ERAM128_BADDR_MASK;
> @@ -10604,6 +10641,7 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		case ZXDH_ERAM128_OPR_64b:
>  			if ((base_addr + (index >> 1)) > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = (index << 6) & ZXDH_ERAM128_BADDR_MASK;
> @@ -10612,6 +10650,7 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		case ZXDH_ERAM128_OPR_32b:
>  			if ((base_addr + (index >> 2)) > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = (index << 5) & ZXDH_ERAM128_BADDR_MASK;
> @@ -10620,6 +10659,7 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		case ZXDH_ERAM128_OPR_1b:
>  			if ((base_addr + (index >> 7)) > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = index & ZXDH_ERAM128_BADDR_MASK;
> @@ -10638,10 +10678,12 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		case ZXDH_ERAM128_OPR_128b:
>  			if ((0xFFFFFFFF - (base_addr)) < (index)) {
>  				PMD_DRV_LOG(ERR, "index 0x%x is invalid!", index);
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_PAR_CHK_INVALID_INDEX;
>  			}
>  			if (base_addr + index > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = (index << 7);
> @@ -10650,6 +10692,7 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		case ZXDH_ERAM128_OPR_64b:
>  			if ((base_addr + (index >> 1)) > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = (index << 6);
> @@ -10658,6 +10701,7 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		case ZXDH_ERAM128_OPR_32b:
>  			if ((base_addr + (index >> 2)) > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
>  				PMD_DRV_LOG(ERR, "index out of range!");
> +				rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  				return ZXDH_ERR;
>  			}
>  			row_index = (index << 5);
> @@ -10665,7 +10709,8 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  			break;
>  		case ZXDH_ERAM128_OPR_1b:
>  			PMD_DRV_LOG(ERR, "rd_clr_mode[%u] or rd_mode[%u] error!",
> -			rd_clr_mode, rd_mode);
> +				rd_clr_mode, rd_mode);
> +			rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  			return ZXDH_ERR;
>  		default:
>  			break;
> @@ -10680,12 +10725,14 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  			&cpu_ind_cmd);
>  	if (rc != ZXDH_OK) {
>  		PMD_DRV_LOG(ERR, "zxdh_np_reg_write failed, rc=0x%x.", rc);
> +		rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  		return ZXDH_ERR;
>  	}
>  
>  	rc = zxdh_np_se_done_status_check(dev_id, ZXDH_SMMU0_SMMU0_CPU_IND_RD_DONER, 0);
>  	if (rc != ZXDH_OK) {
>  		PMD_DRV_LOG(ERR, "se done status check failed, rc=0x%x.", rc);
> +		rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  		return ZXDH_ERR;
>  	}
>  
> @@ -10698,6 +10745,7 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  			p_temp_data + 3 - i);
>  		if (rc != ZXDH_OK) {
>  			PMD_DRV_LOG(ERR, "zxdh_np_reg_write failed, rc=0x%x.", rc);
> +			rte_spinlock_unlock(&p_ind_spinlock->spinlock);
>  			return ZXDH_ERR;
>  		}
>  	}
> @@ -10736,6 +10784,8 @@ zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
>  		}
>  	}
>  
> +	rte_spinlock_unlock(&p_ind_spinlock->spinlock);
> +
>  	return rc;
>  }
>  
> @@ -10789,7 +10839,7 @@ zxdh_np_agent_channel_plcr_sync_send(uint32_t dev_id, ZXDH_AGENT_CHANNEL_PLCR_MS
>  {
>  	uint32_t ret = 0;
>  	ZXDH_AGENT_CHANNEL_MSG_T agent_msg = {
> -		.msg = (void *)&p_msg,
> +		.msg = (void *)p_msg,
>  		.msg_len = sizeof(ZXDH_AGENT_CHANNEL_PLCR_MSG_T),
>  	};
>  
> @@ -11012,7 +11062,8 @@ zxdh_np_stat_carc_queue_cfg_set(uint32_t dev_id,
>  }
>  
>  uint32_t
> -zxdh_np_car_profile_id_add(uint32_t vport_id,
> +zxdh_np_car_profile_id_add(uint32_t dev_id,
> +		uint32_t vport_id,
>  		uint32_t flags,
>  		uint64_t *p_profile_id)
>  {
> @@ -11027,7 +11078,7 @@ zxdh_np_car_profile_id_add(uint32_t vport_id,
>  		PMD_DRV_LOG(ERR, "profile_id point null!");
>  		return ZXDH_PAR_CHK_POINT_NULL;
>  	}
> -	ret = zxdh_np_agent_channel_plcr_profileid_request(0, vport_id, flags, profile_id);
> +	ret = zxdh_np_agent_channel_plcr_profileid_request(dev_id, vport_id, flags, profile_id);
>  
>  	profile_id_h = *(profile_id + 1);
>  	profile_id_l = *profile_id;
> @@ -11045,14 +11096,14 @@ zxdh_np_car_profile_id_add(uint32_t vport_id,
>  }
>  
>  uint32_t
> -zxdh_np_car_profile_cfg_set(uint32_t vport_id __rte_unused,
> +zxdh_np_car_profile_cfg_set(uint32_t dev_id,
> +		uint32_t vport_id __rte_unused,
>  		uint32_t car_type,
>  		uint32_t pkt_sign,
>  		uint32_t profile_id,
>  		void *p_car_profile_cfg)
>  {
>  	uint32_t ret = 0;
> -	uint32_t dev_id = 0;
>  
>  	ret = zxdh_np_agent_channel_plcr_car_rate(dev_id, car_type,
>  		pkt_sign, profile_id, p_car_profile_cfg);
> @@ -11065,11 +11116,10 @@ zxdh_np_car_profile_cfg_set(uint32_t vport_id __rte_unused,
>  }
>  
>  uint32_t
> -zxdh_np_car_profile_id_delete(uint32_t vport_id,
> +zxdh_np_car_profile_id_delete(uint32_t dev_id, uint32_t vport_id,
>  	uint32_t flags, uint64_t profile_id)
>  {
>  	uint32_t ret = 0;
> -	uint32_t dev_id = 0;
>  	uint32_t profileid = profile_id & 0xFFFF;
>  
>  	ret = zxdh_np_agent_channel_plcr_profileid_release(dev_id, vport_id, flags, profileid);
> diff --git a/drivers/net/zxdh/zxdh_np.h b/drivers/net/zxdh/zxdh_np.h
> index b1d8b1aef8..1b8f17474d 100644
> --- a/drivers/net/zxdh/zxdh_np.h
> +++ b/drivers/net/zxdh/zxdh_np.h
> @@ -1934,15 +1934,17 @@ uint32_t zxdh_np_stat_ppu_cnt_get_ex(uint32_t dev_id,
>  			uint32_t clr_mode,
>  			uint32_t *p_data);
>  uint32_t
> -zxdh_np_car_profile_id_add(uint32_t vport_id,
> +zxdh_np_car_profile_id_add(uint32_t dev_id,
> +			uint32_t vport_id,
>  			uint32_t flags,
>  			uint64_t *p_profile_id);
> -uint32_t zxdh_np_car_profile_cfg_set(uint32_t vport_id,
> +uint32_t zxdh_np_car_profile_cfg_set(uint32_t dev_id,
> +			uint32_t vport_id,
>  			uint32_t car_type,
>  			uint32_t pkt_sign,
>  			uint32_t profile_id,
>  			void *p_car_profile_cfg);
> -uint32_t zxdh_np_car_profile_id_delete(uint32_t vport_id,
> +uint32_t zxdh_np_car_profile_id_delete(uint32_t dev_id, uint32_t vport_id,
>  			uint32_t flags, uint64_t profile_id);
>  uint32_t zxdh_np_stat_car_queue_cfg_set(uint32_t dev_id,
>  			uint32_t car_type,
> diff --git a/drivers/net/zxdh/zxdh_pci.c b/drivers/net/zxdh/zxdh_pci.c
> index 3d1a3ff0dd..4ff0f065df 100644
> --- a/drivers/net/zxdh/zxdh_pci.c
> +++ b/drivers/net/zxdh/zxdh_pci.c
> @@ -27,6 +27,23 @@
>  		1ULL << ZXDH_F_NOTIFICATION_DATA | \
>  		1ULL << ZXDH_NET_F_MAC)
>  
> +#define ZXDH_PMD_DEFAULT_HOST_FEATURES   \
> +	(1ULL << ZXDH_NET_F_MRG_RXBUF | \
> +	 1ULL << ZXDH_NET_F_STATUS    | \
> +	 1ULL << ZXDH_NET_F_MQ        | \
> +	 1ULL << ZXDH_F_ANY_LAYOUT    | \
> +	 1ULL << ZXDH_F_VERSION_1   | \
> +	 1ULL << ZXDH_F_RING_PACKED | \
> +	 1ULL << ZXDH_F_IN_ORDER    | \
> +	 1ULL << ZXDH_F_NOTIFICATION_DATA |\
> +	 1ULL << ZXDH_NET_F_MAC | \
> +	 1ULL << ZXDH_NET_F_CSUM |\
> +	 1ULL << ZXDH_NET_F_GUEST_CSUM |\
> +	 1ULL << ZXDH_NET_F_GUEST_TSO4 |\
> +	 1ULL << ZXDH_NET_F_GUEST_TSO6 |\
> +	 1ULL << ZXDH_NET_F_HOST_TSO4 |\
> +	 1ULL << ZXDH_NET_F_HOST_TSO6)
> +
>  static void
>  zxdh_read_dev_config(struct zxdh_hw *hw, size_t offset,
>  		void *dst, int32_t length)
> @@ -391,13 +408,18 @@ zxdh_pci_read_dev_config(struct zxdh_hw *hw, size_t offset, void *dst, int32_t l
>  	ZXDH_VTPCI_OPS(hw)->read_dev_cfg(hw, offset, dst, length);
>  }
>  
> +void zxdh_pci_write_dev_config(struct zxdh_hw *hw, size_t offset, const void *src, int32_t length)
> +{
> +	ZXDH_VTPCI_OPS(hw)->write_dev_cfg(hw, offset, src, length);
> +}
> +
>  void
>  zxdh_get_pci_dev_config(struct zxdh_hw *hw)
>  {
>  	uint64_t guest_features = 0;
>  	uint64_t nego_features = 0;
>  
> -	hw->host_features = zxdh_pci_get_features(hw);
> +	hw->host_features = ZXDH_PMD_DEFAULT_HOST_FEATURES;
>  
>  	guest_features = (uint64_t)ZXDH_PMD_DEFAULT_GUEST_FEATURES;
>  	nego_features = guest_features & hw->host_features;
> diff --git a/drivers/net/zxdh/zxdh_pci.h b/drivers/net/zxdh/zxdh_pci.h
> index 9b8bef6c09..a1834f6615 100644
> --- a/drivers/net/zxdh/zxdh_pci.h
> +++ b/drivers/net/zxdh/zxdh_pci.h
> @@ -162,7 +162,7 @@ void zxdh_pci_read_dev_config(struct zxdh_hw *hw, size_t offset,
>  
>  int32_t zxdh_read_pci_caps(struct rte_pci_device *dev, struct zxdh_hw *hw);
>  void zxdh_get_pci_dev_config(struct zxdh_hw *hw);
> -
> +void zxdh_pci_write_dev_config(struct zxdh_hw *hw, size_t offset, const void *src, int32_t length);
>  uint16_t zxdh_pci_get_features(struct zxdh_hw *hw);
>  enum zxdh_msix_status zxdh_pci_msix_detect(struct rte_pci_device *dev);
>  uint8_t zxdh_pci_isr(struct zxdh_hw *hw);
> diff --git a/drivers/net/zxdh/zxdh_rxtx.c b/drivers/net/zxdh/zxdh_rxtx.c
> index 1921a23f25..9bb57d4f84 100644
> --- a/drivers/net/zxdh/zxdh_rxtx.c
> +++ b/drivers/net/zxdh/zxdh_rxtx.c
> @@ -760,7 +760,6 @@ zxdh_rx_update_mbuf(struct rte_mbuf *m, struct zxdh_net_hdr_ul *hdr)
>  		idx = (pkt_type_inner >> 4)  & 0xF;
>  		m->packet_type |= zxdh_inner_l4_type[idx];
>  	}
> -
>  }
>  
>  static void zxdh_discard_rxbuf(struct zxdh_virtqueue *vq, struct rte_mbuf *m)
> @@ -818,9 +817,14 @@ zxdh_recv_pkts_packed(void *rx_queue, struct rte_mbuf **rx_pkts,
>  		seg_num  = header->type_hdr.num_buffers;
>  
>  		/* Private queue only handle type hdr */
> -		hdr_size = ZXDH_TYPE_HDR_SIZE;
> -		rxm->pkt_len = ((header->type_hdr.port & 0x7f) << 8) +
> -							header->type_hdr.pd_len;
> +		hdr_size = header->type_hdr.pd_len << 1;
> +		if (unlikely(hdr_size > lens[i] || hdr_size < ZXDH_TYPE_HDR_SIZE)) {
> +			PMD_RX_LOG(ERR, "hdr_size:%u is invalid", hdr_size);
> +			rte_pktmbuf_free(rxm);
> +			rxvq->stats.errors++;
> +			rxvq->stats.invalid_hdr_len_err++;
> +			continue;
> +		}
>  		rxm->data_off += hdr_size;
>  		rxm->nb_segs = seg_num;
>  		rxm->ol_flags = 0;
> diff --git a/drivers/net/zxdh/zxdh_tables.c b/drivers/net/zxdh/zxdh_tables.c
> index 253d9ce438..ab91d51948 100644
> --- a/drivers/net/zxdh/zxdh_tables.c
> +++ b/drivers/net/zxdh/zxdh_tables.c
> @@ -8,14 +8,7 @@
>  #include "zxdh_tables.h"
>  #include "zxdh_logs.h"
>  
> -#define ZXDH_SDT_VPORT_ATT_TABLE          1
> -#define ZXDH_SDT_PANEL_ATT_TABLE          2
> -#define ZXDH_SDT_RSS_ATT_TABLE            3
> -#define ZXDH_SDT_VLAN_ATT_TABLE           4
> -#define ZXDH_SDT_BROCAST_ATT_TABLE        6
> -#define ZXDH_SDT_UNICAST_ATT_TABLE        10
> -#define ZXDH_SDT_MULTICAST_ATT_TABLE      11
> -#define ZXDH_SDT_PORT_VLAN_ATT_TABLE      16
> +
>  
>  #define ZXDH_MAC_HASH_INDEX_BASE          64
>  #define ZXDH_MAC_HASH_INDEX(index)        (ZXDH_MAC_HASH_INDEX_BASE + (index))
> @@ -40,15 +33,16 @@ zxdh_set_port_attr(struct zxdh_hw *hw, uint16_t vport, struct zxdh_port_attr_tab
>  {
>  	struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> +	uint16_t vfid = zxdh_vport_to_vfid(vport_num);
>  	int ret = 0;
>  
> -	ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vport_num.vfid, (uint32_t *)port_attr};
> +	ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vfid, (uint32_t *)port_attr};
>  	ZXDH_DTB_USER_ENTRY_T user_entry_write = {ZXDH_SDT_VPORT_ATT_TABLE, (void *)&entry};
>  
>  	ret = zxdh_np_dtb_table_entry_write(hw->slot_id,
>  				dtb_data->queueid, 1, &user_entry_write);
>  	if (ret != 0)
> -		PMD_DRV_LOG(ERR, "write vport_att failed vfid:%d failed", vport_num.vfid);
> +		PMD_DRV_LOG(ERR, "write vport_att failed vfid:%d failed", vfid);
>  
>  	return ret;
>  }
> @@ -72,6 +66,7 @@ zxdh_port_attr_init(struct rte_eth_dev *dev)
>  		port_attr.mtu = dev->data->mtu;
>  		port_attr.mtu_enable = 1;
>  		port_attr.is_up = 0;
> +		port_attr.hash_search_index = hw->hash_search_index;
>  		if (!port_attr.rss_enable)
>  			port_attr.port_base_qid = 0;
>  
> @@ -144,6 +139,7 @@ int zxdh_panel_table_init(struct rte_eth_dev *dev)
>  	panel.pf_vfid = zxdh_vport_to_vfid(hw->vport);
>  	panel.mtu_enable = 1;
>  	panel.mtu = dev->data->mtu;
> +	panel.port_vfid_1588 = panel.pf_vfid;
>  
>  	ZXDH_DTB_ERAM_ENTRY_INFO_T panel_entry = {
>  		.index = hw->phyport,
> @@ -212,13 +208,14 @@ zxdh_get_port_attr(struct zxdh_hw *hw, uint16_t vport, struct zxdh_port_attr_tab
>  {
>  	struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> -	ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vport_num.vfid, (uint32_t *)port_attr};
> +	uint16_t vfid = zxdh_vport_to_vfid(vport_num);
> +	ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vfid, (uint32_t *)port_attr};
>  	ZXDH_DTB_USER_ENTRY_T user_entry_get = {ZXDH_SDT_VPORT_ATT_TABLE, &entry};
>  	int ret;
>  
>  	ret = zxdh_np_dtb_table_entry_get(hw->slot_id, dtb_data->queueid, &user_entry_get, 1);
>  	if (ret != 0)
> -		PMD_DRV_LOG(ERR, "get port_attr vfid:%d failed, ret:%d", vport_num.vfid, ret);
> +		PMD_DRV_LOG(ERR, "get port_attr vfid:%d failed, ret:%d", vfid, ret);
>  
>  	return ret;
>  }
> @@ -229,7 +226,8 @@ zxdh_delete_port_attr(struct zxdh_hw *hw, uint16_t vport,
>  {
>  	struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> -	ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vport_num.vfid, (uint32_t *)port_attr};
> +	uint16_t vfid = zxdh_vport_to_vfid(vport_num);
> +	ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vfid, (uint32_t *)port_attr};
>  	ZXDH_DTB_USER_ENTRY_T user_entry = {
>  		.sdt_no = ZXDH_SDT_VPORT_ATT_TABLE,
>  		.p_entry_data = (void *)&entry
> @@ -247,9 +245,9 @@ zxdh_add_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
>  	struct zxdh_mac_unicast_table unicast_table = {0};
>  	struct zxdh_mac_multicast_table multicast_table = {0};
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> +	uint16_t vfid = zxdh_vport_to_vfid(vport_num);
>  	uint32_t ret;
>  	uint16_t group_id = 0;
> -	uint16_t vfid = vport_num.vfid;
>  
>  	if (rte_is_unicast_ether_addr(addr)) {
>  		rte_memcpy(unicast_table.key.dmac_addr, addr, sizeof(struct rte_ether_addr));
> @@ -351,15 +349,17 @@ zxdh_del_mac_table(struct zxdh_hw *hw, uint16_t vport, struct rte_ether_addr *ad
>  	struct zxdh_mac_unicast_table unicast_table = {0};
>  	struct zxdh_mac_multicast_table multicast_table = {0};
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> -	uint32_t ret, del_flag = 0;
> -	uint16_t group_id = 0;
>  	union zxdh_virport_num port = (union zxdh_virport_num)vport;
>  	uint16_t vfid = zxdh_vport_to_vfid(port);
> +	uint32_t ret, del_flag = 0;
> +	uint16_t group_id = 0;
>  
>  	if (rte_is_unicast_ether_addr(addr)) {
>  		rte_memcpy(unicast_table.key.dmac_addr, addr, sizeof(struct rte_ether_addr));
>  		unicast_table.key.sriov_vlan_id = srv_vlanid;
>  		unicast_table.key.sriov_vlan_tpid = srv_tpid;
> +		unicast_table.entry.hit_flag = 0;
> +		unicast_table.entry.vfid = rte_cpu_to_be_16(vfid & 0x7ff);
>  
>  		ZXDH_DTB_HASH_ENTRY_INFO_T dtb_hash_entry = {
>  			.p_actu_key = (uint8_t *)&unicast_table.key,
> @@ -800,6 +800,7 @@ zxdh_rss_table_set(struct zxdh_hw *hw, uint16_t vport, struct zxdh_rss_reta *rss
>  	struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
>  	struct zxdh_rss_to_vqid_table rss_vqid = {0};
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> +	uint16_t vfid = zxdh_vport_to_vfid(vport_num);
>  	int ret = 0;
>  
>  	for (uint16_t i = 0; i < RTE_ETH_RSS_RETA_SIZE_256 / 8; i++) {
> @@ -820,7 +821,7 @@ zxdh_rss_table_set(struct zxdh_hw *hw, uint16_t vport, struct zxdh_rss_reta *rss
>  			rss_vqid.vqm_qid[0] |= 0x8000;
>  #endif
>  		ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {
> -			.index = vport_num.vfid * 32 + i,
> +			.index = vfid * 32 + i,
>  			.p_data = (uint32_t *)&rss_vqid
>  		};
>  		ZXDH_DTB_USER_ENTRY_T user_entry_write = {
> @@ -830,7 +831,7 @@ zxdh_rss_table_set(struct zxdh_hw *hw, uint16_t vport, struct zxdh_rss_reta *rss
>  		ret = zxdh_np_dtb_table_entry_write(hw->slot_id,
>  					dtb_data->queueid, 1, &user_entry_write);
>  		if (ret != 0) {
> -			PMD_DRV_LOG(ERR, "write rss base qid failed vfid:%d", vport_num.vfid);
> +			PMD_DRV_LOG(ERR, "write rss base qid failed vfid:%d", vfid);
>  			return ret;
>  		}
>  	}
> @@ -843,16 +844,17 @@ zxdh_rss_table_get(struct zxdh_hw *hw, uint16_t vport, struct zxdh_rss_reta *rss
>  	struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
>  	struct zxdh_rss_to_vqid_table rss_vqid = {0};
>  	union zxdh_virport_num vport_num = (union zxdh_virport_num)vport;
> +	uint16_t vfid = zxdh_vport_to_vfid(vport_num);
>  	int ret = 0;
>  
>  	for (uint16_t i = 0; i < RTE_ETH_RSS_RETA_SIZE_256 / 8; i++) {
> -		ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vport_num.vfid * 32 + i, (uint32_t *)&rss_vqid};
> +		ZXDH_DTB_ERAM_ENTRY_INFO_T entry = {vfid * 32 + i, (uint32_t *)&rss_vqid};
>  		ZXDH_DTB_USER_ENTRY_T user_entry = {ZXDH_SDT_RSS_ATT_TABLE, &entry};
>  
>  		ret = zxdh_np_dtb_table_entry_get(hw->slot_id,
>  					dtb_data->queueid, &user_entry, 1);
>  		if (ret != 0) {
> -			PMD_DRV_LOG(ERR, "get rss tbl failed, vfid:%d", vport_num.vfid);
> +			PMD_DRV_LOG(ERR, "get rss tbl failed, vfid:%d", vfid);
>  			return -1;
>  		}
>  
> diff --git a/drivers/net/zxdh/zxdh_tables.h b/drivers/net/zxdh/zxdh_tables.h
> index 2f2ada3a9f..cb34e38be8 100644
> --- a/drivers/net/zxdh/zxdh_tables.h
> +++ b/drivers/net/zxdh/zxdh_tables.h
> @@ -9,7 +9,13 @@
>  
>  /* eram */
>  #define ZXDH_SDT_VPORT_ATT_TABLE          1
> -
> +#define ZXDH_SDT_PANEL_ATT_TABLE          2
> +#define ZXDH_SDT_RSS_ATT_TABLE            3
> +#define ZXDH_SDT_VLAN_ATT_TABLE           4
> +#define ZXDH_SDT_BROCAST_ATT_TABLE        6
> +#define ZXDH_SDT_UNICAST_ATT_TABLE        10
> +#define ZXDH_SDT_MULTICAST_ATT_TABLE      11
> +#define ZXDH_SDT_PORT_VLAN_ATT_TABLE      16
>  /* hash */
>  #define ZXDH_SDT_L2_ENTRY_TABLE0          64
>  #define ZXDH_SDT_L2_ENTRY_TABLE1          65
> @@ -80,8 +86,6 @@
>  #define ZXDH_MTR_STATS_EGRESS_BASE           0x7481
>  #define ZXDH_MTR_STATS_INGRESS_BASE          0x7C81
>  
> -extern struct zxdh_dtb_shared_data g_dtb_data;
> -
>  struct zxdh_port_vlan_table {
>  #if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
>  	uint16_t business_vlan_tpid:16;
> @@ -233,19 +237,51 @@ struct zxdh_port_attr_table {
>  };
>  
>  struct zxdh_panel_table {
> -	uint16_t port_vfid_1588 : 11,
> -			 rsv2           : 5;
> -	uint16_t pf_vfid        : 11,
> -			 rsv1           : 1,
> -			 enable_1588_tc : 2,
> -			 trust_mode     : 1,
> -			 hit_flag       : 1;
> -	uint32_t mtu            : 16,
> -			 mtu_enable     : 1,
> -			 rsv            : 3,
> -			 tm_base_queue  : 12;
> -	uint32_t rsv_1;
> -	uint32_t rsv_2;
> +#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
> +	uint16_t port_vfid_1588   : 11,
> +				rsv2             : 5;
> +	uint16_t rsv1             : 11,
> +			 tm_shape_enable  : 1,
> +			 enable_1588_tc   : 2,
> +			 trust_mode       : 1,
> +			 hit_flag         : 1;
> +	uint16_t mtu              : 16;
> +	uint16_t mtu_enable       : 1,
> +			 rsv              : 3,
> +			 tm_base_queue    : 12;
> +	uint16_t lacp_pf_qid      : 12,
> +				rsv5             : 4;
> +	uint16_t lacp_pf_vfid     : 11,
> +				rsv6             : 2,
> +				member_port_up   : 1,
> +				bond_link_up     : 1,
> +				hw_bond_enable   : 1;
> +	uint16_t rsv3             : 16;
> +	uint16_t pf_vfid          : 11,
> +				rsv4             : 5;
> +#else
> +	uint16_t rsv1             : 11,
> +				tm_shape_enable  : 1,
> +				enable_1588_tc   : 2,
> +				trust_mode       : 1,
> +				hit_flag         : 1;
> +	uint16_t port_vfid_1588   : 11,
> +				rsv2             : 5;
> +	uint16_t mtu_enable       : 1,
> +				rsv              : 3,
> +				tm_base_queue    : 12;
> +	uint16_t mtu              : 16;
> +	uint16_t lacp_pf_vfid     : 11,
> +				rsv6             : 2,
> +				member_port_up   : 1,
> +				bond_link_up     : 1,
> +				hw_bond_enable   : 1;
> +	uint16_t lacp_pf_qid      : 12,
> +				rsv5             : 4;
> +	uint16_t pf_vfid          : 11,
> +				rsv4             : 5;
> +	uint16_t rsv3             : 16;
> +#endif
>  }; /* 16B */
>  
>  struct zxdh_mac_unicast_key {

