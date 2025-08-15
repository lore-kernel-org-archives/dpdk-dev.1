Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC010CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 08:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EEC1402A5;
	Fri, 15 Aug 2025 10:01:02 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8EAF8400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 10:01:00 +0200 (CEST)
Received: from debian (unknown [78.109.69.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id C27B1E003D;
 Fri, 15 Aug 2025 12:00:59 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am C27B1E003D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1755244860;
 bh=DWNX1xT+Lu1VWymhdCKWd2S/q3BZwPj78Qy51YVbP6I=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=hu8Dv35uoGpdiDWigsbRAErUQKQCBVd3IG0x6puixXFg286w8T4DWMOpMQOLASaf7
 mYp7r1TtsqpKn39Wy/+CW6cLsryNlZSx6lLwcYewO1BSMYMMpCyoBxfQ2urUKpMs06
 9YI82N2rll6LKAWbjEDkQDQ3mnIhMmLRoVZT752KC21lUSjOVd7sDMDtmq0688oNuC
 Ml/hqCXjSMaXd3T4THKi5k4NRT428OgTZeYzCj2DhI4ztXqIXD3ViCTEl/RZxS6y7k
 aKHI5pj2sepxoVGMAKI/bwmYjqlE2geZcPHRXyEXv2TH+BQ9qRwq9D53qEInqt+JgQ
 u/zuvjCBtspTQ==
Date: Fri, 15 Aug 2025 12:00:58 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
cc: stephen@networkplumber.org, wang.junlong1@zte.com.cn, 
 yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v6 2/2] net/zxdh: add support flow director ops
In-Reply-To: <20250815074221.2254545-3-chen.bingbin@zte.com.cn>
Message-ID: <6bbeb757-725f-3690-c7b4-031eb455b7ac@arknetworks.am>
References: <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
 <20250815074221.2254545-1-chen.bingbin@zte.com.cn>
 <20250815074221.2254545-3-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1721063060-1755244860=:9147"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1721063060-1755244860=:9147
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 15 Aug 2025, Bingbin Chen wrote:

> Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN,
> and mask matching, supporting multiple actions
> include drop/count/mark/queue/rss,and vxlan decap/encap.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---
>  doc/guides/nics/features/zxdh.ini  |   16 +
>  doc/guides/nics/zxdh.rst           |    1 +
>  drivers/net/zxdh/meson.build       |    1 +
>  drivers/net/zxdh/zxdh_common.h     |    1 +
>  drivers/net/zxdh/zxdh_ethdev.c     |   26 +
>  drivers/net/zxdh/zxdh_ethdev.h     |   12 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.c |    2 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |    1 +
>  drivers/net/zxdh/zxdh_flow.c       | 2017 ++++++++++++++++++++++++++++
>  drivers/net/zxdh/zxdh_flow.h       |  240 ++++
>  drivers/net/zxdh/zxdh_msg.c        |  264 +++-
>  drivers/net/zxdh/zxdh_msg.h        |   31 +-
>  drivers/net/zxdh/zxdh_tables.h     |   10 +-
>  13 files changed, 2549 insertions(+), 73 deletions(-)
>  create mode 100644 drivers/net/zxdh/zxdh_flow.c
>  create mode 100644 drivers/net/zxdh/zxdh_flow.h
> 
> diff --git a/doc/guides/nics/features/zxdh.ini b/doc/guides/nics/features/zxdh.ini
> index 277e17a584..bd20838676 100644
> --- a/doc/guides/nics/features/zxdh.ini
> +++ b/doc/guides/nics/features/zxdh.ini
> @@ -34,5 +34,21 @@ Extended stats       = Y
>  FW version           = Y
>  Module EEPROM dump   = Y
>  
> +[rte_flow items]
> +eth                  = Y
> +ipv4                 = Y
> +ipv6                 = Y
> +sctp                 = Y
> +tcp                  = Y
> +udp                  = Y
> +vlan                 = Y
> +vxlan                = Y
> +
>  [rte_flow actions]
>  drop                 = Y
> +count                = Y
> +mark                 = Y
> +queue                = Y
> +rss                  = Y
> +vxlan_decap          = Y
> +vxlan_encap          = Y
> diff --git a/doc/guides/nics/zxdh.rst b/doc/guides/nics/zxdh.rst
> index 372cb5b44f..47dabde97e 100644
> --- a/doc/guides/nics/zxdh.rst
> +++ b/doc/guides/nics/zxdh.rst
> @@ -41,6 +41,7 @@ Features of the ZXDH PMD are:
>  - Hardware TSO for generic IP or UDP tunnel, including VXLAN
>  - Extended statistics query
>  - Ingress meter support
> +- Flow API
>  
>  
>  Driver compilation and testing
> diff --git a/drivers/net/zxdh/meson.build b/drivers/net/zxdh/meson.build
> index ec71451a55..7554d4dc60 100644
> --- a/drivers/net/zxdh/meson.build
> +++ b/drivers/net/zxdh/meson.build
> @@ -24,4 +24,5 @@ sources = files(
>          'zxdh_rxtx.c',
>          'zxdh_ethdev_ops.c',
>          'zxdh_mtr.c',
> +        'zxdh_flow.c',
>  )
> diff --git a/drivers/net/zxdh/zxdh_common.h b/drivers/net/zxdh/zxdh_common.h
> index c151101bbc..6d78ae0273 100644
> --- a/drivers/net/zxdh/zxdh_common.h
> +++ b/drivers/net/zxdh/zxdh_common.h
> @@ -14,6 +14,7 @@
>  #define ZXDH_VF_LOCK_REG               0x90
>  #define ZXDH_VF_LOCK_ENABLE_MASK       0x1
>  #define ZXDH_ACQUIRE_CHANNEL_NUM_MAX   10
> +#define VF_IDX(pcie_id)     ((pcie_id) & 0xff)
>  
>  struct zxdh_res_para {
>      uint64_t virt_addr;
> diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
> index c7864a8bef..0429bd0333 100644
> --- a/drivers/net/zxdh/zxdh_ethdev.c
> +++ b/drivers/net/zxdh/zxdh_ethdev.c
> @@ -1272,6 +1272,11 @@ zxdh_dev_close(struct rte_eth_dev *dev)
>          return -1;
>      }
>  
> +    if (zxdh_shared_data != NULL) {
> +        zxdh_mtr_release(dev);
> +        zxdh_flow_release(dev);
> +    }
> +
>      zxdh_intr_release(dev);
>      zxdh_np_uninit(dev);
>      zxdh_pci_reset(hw);
> @@ -1487,6 +1492,7 @@ static const struct eth_dev_ops zxdh_eth_dev_ops = {
>      .get_module_eeprom         = zxdh_dev_get_module_eeprom,
>      .dev_supported_ptypes_get = zxdh_dev_supported_ptypes_get,
>      .mtr_ops_get             = zxdh_meter_ops_get,
> +    .flow_ops_get             = zxdh_flow_ops_get,
>  };
>  
>  static int32_t
> @@ -1567,6 +1573,8 @@ zxdh_dtb_dump_res_init(struct zxdh_hw *hw, ZXDH_DEV_INIT_CTRL_T *dpp_ctrl)
>          {"sdt_mc_table1",       5 * 1024 * 1024, ZXDH_SDT_MC_TABLE1, NULL},
>          {"sdt_mc_table2",       5 * 1024 * 1024, ZXDH_SDT_MC_TABLE2, NULL},
>          {"sdt_mc_table3",       5 * 1024 * 1024, ZXDH_SDT_MC_TABLE3, NULL},
> +        {"sdt_acl_index_mng",   4 * 1024 * 1024, 30, NULL},
> +        {"sdt_fd_table",        4 * 1024 * 1024, ZXDH_SDT_FD_TABLE, NULL},
>      };
>  
>      struct zxdh_dev_shared_data *dev_sd = hw->dev_sd;
> @@ -1786,6 +1794,7 @@ zxdh_free_sh_res(void)
>          rte_spinlock_lock(&zxdh_shared_data_lock);
>          if (zxdh_shared_data != NULL && zxdh_shared_data->init_done &&
>              (--zxdh_shared_data->dev_refcnt == 0)) {
> +            rte_mempool_free(zxdh_shared_data->flow_mp);
>              rte_mempool_free(zxdh_shared_data->mtr_mp);
>              rte_mempool_free(zxdh_shared_data->mtr_profile_mp);
>              rte_mempool_free(zxdh_shared_data->mtr_policy_mp);
> @@ -1797,6 +1806,7 @@ zxdh_free_sh_res(void)
>  static int
>  zxdh_init_sh_res(struct zxdh_shared_data *sd)
>  {
> +    const char *MZ_ZXDH_FLOW_MP        = "zxdh_flow_mempool";
>      const char *MZ_ZXDH_MTR_MP         = "zxdh_mtr_mempool";
>      const char *MZ_ZXDH_MTR_PROFILE_MP = "zxdh_mtr_profile_mempool";
>      const char *MZ_ZXDH_MTR_POLICY_MP = "zxdh_mtr_policy_mempool";
> @@ -1806,6 +1816,13 @@ zxdh_init_sh_res(struct zxdh_shared_data *sd)
>      struct rte_mempool *mtr_policy_mp = NULL;
>  
>      if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +        flow_mp = rte_mempool_create(MZ_ZXDH_FLOW_MP, ZXDH_MAX_FLOW_NUM,
> +            sizeof(struct zxdh_flow), 64, 0,
> +            NULL, NULL, NULL, NULL, SOCKET_ID_ANY, 0);
> +        if (flow_mp == NULL) {
> +            PMD_DRV_LOG(ERR, "Cannot allocate zxdh flow mempool");
> +            goto error;
> +        }
>          mtr_mp = rte_mempool_create(MZ_ZXDH_MTR_MP, ZXDH_MAX_MTR_NUM,
>              sizeof(struct zxdh_mtr_object), 64, 0,
>              NULL, NULL, NULL, NULL, SOCKET_ID_ANY, 0);
> @@ -1828,6 +1845,7 @@ zxdh_init_sh_res(struct zxdh_shared_data *sd)
>              PMD_DRV_LOG(ERR, "Cannot allocate zxdh mtr profile mempool");
>              goto error;
>          }
> +        sd->flow_mp = flow_mp;
>          sd->mtr_mp = mtr_mp;
>          sd->mtr_profile_mp = mtr_profile_mp;
>          sd->mtr_policy_mp = mtr_policy_mp;
> @@ -1877,6 +1895,7 @@ zxdh_init_once(struct rte_eth_dev *eth_dev)
>          ret = zxdh_init_sh_res(sd);
>          if (ret != 0)
>              goto out;
> +        zxdh_flow_global_init();
>          rte_spinlock_init(&g_mtr_res.hw_plcr_res_lock);
>          memset(&g_mtr_res, 0, sizeof(g_mtr_res));
>          sd->init_done = true;
> @@ -1904,6 +1923,12 @@ zxdh_tbl_entry_offline_destroy(struct zxdh_hw *hw)
>          ret = zxdh_np_dtb_hash_offline_delete(hw->dev_id, dtb_data->queueid, sdt_no, 0);
>          if (ret)
>              PMD_DRV_LOG(ERR, "sdt_no %d delete failed. code:%d ", sdt_no, ret);
> +
> +        ret = zxdh_np_dtb_acl_offline_delete(hw->dev_id, dtb_data->queueid,
> +                    ZXDH_SDT_FD_TABLE, hw->vport.vport,
> +                    ZXDH_FLOW_STATS_INGRESS_BASE, 1);
> +        if (ret)
> +            PMD_DRV_LOG(ERR, "flow offline delete failed. code:%d", ret);
>      }
>      return ret;
>  }
> @@ -2153,6 +2178,7 @@ zxdh_eth_dev_init(struct rte_eth_dev *eth_dev)
>      if (ret)
>          goto err_zxdh_init;
>  
> +    zxdh_flow_init(eth_dev);
>      zxdh_queue_res_get(eth_dev);
>      zxdh_msg_cb_reg(hw);
>      if (zxdh_priv_res_init(hw) != 0)
> diff --git a/drivers/net/zxdh/zxdh_ethdev.h b/drivers/net/zxdh/zxdh_ethdev.h
> index f8456f9b22..a2d7b14601 100644
> --- a/drivers/net/zxdh/zxdh_ethdev.h
> +++ b/drivers/net/zxdh/zxdh_ethdev.h
> @@ -11,6 +11,7 @@
>  #include <eal_interrupts.h>
>  
>  #include "zxdh_mtr.h"
> +#include "zxdh_flow.h"
>  
>  /* ZXDH PCI vendor/device ID. */
>  #define ZXDH_PCI_VENDOR_ID        0x1cf2
> @@ -134,7 +135,10 @@ struct zxdh_hw {
>      uint8_t is_pf         : 1,
>              switchoffload : 1,
>              i_mtr_en      : 1,
> -            e_mtr_en      : 1;
> +            e_mtr_en      : 1,
> +            i_flow_en     : 1,
> +            e_flow_en     : 1,
> +            vxlan_flow_en : 1;
>      uint8_t msg_chan_init;
>      uint8_t phyport;
>      uint8_t panel_id;
> @@ -154,7 +158,10 @@ struct zxdh_hw {
>      uint16_t queue_pool_count;
>      uint16_t queue_pool_start;
>      uint8_t dl_net_hdr_len;
> -    uint8_t rsv1[3];
> +    uint16_t vxlan_fd_num;
> +    uint8_t rsv1[1];
> +
> +    struct dh_flow_list dh_flow_list;
>  };
>  
>  struct zxdh_dtb_shared_data {
> @@ -179,6 +186,7 @@ struct zxdh_shared_data {
>      int32_t np_init_done;
>      uint32_t dev_refcnt;
>      struct zxdh_dtb_shared_data *dtb_data;
> +    struct rte_mempool *flow_mp;
>      struct rte_mempool *mtr_mp;
>      struct rte_mempool *mtr_profile_mp;
>      struct rte_mempool *mtr_policy_mp;
> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
> index 39078b99d2..da32512b03 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.c
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
> @@ -1120,7 +1120,7 @@ zxdh_dev_rss_reta_update(struct rte_eth_dev *dev,
>      return ret;
>  }
>  
> -static uint16_t
> +uint16_t
>  zxdh_hw_qid_to_logic_qid(struct rte_eth_dev *dev, uint16_t qid)
>  {
>      struct zxdh_hw *priv = (struct zxdh_hw *)dev->data->dev_private;
> diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.h b/drivers/net/zxdh/zxdh_ethdev_ops.h
> index 6015b3de59..86db6efe40 100644
> --- a/drivers/net/zxdh/zxdh_ethdev_ops.h
> +++ b/drivers/net/zxdh/zxdh_ethdev_ops.h
> @@ -142,5 +142,6 @@ int zxdh_dev_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw
>  int zxdh_dev_get_module_info(struct rte_eth_dev *dev, struct rte_eth_dev_module_info *modinfo);
>  int zxdh_dev_get_module_eeprom(struct rte_eth_dev *dev, struct rte_dev_eeprom_info *info);
>  int zxdh_meter_ops_get(struct rte_eth_dev *dev, void *arg);
> +uint16_t zxdh_hw_qid_to_logic_qid(struct rte_eth_dev *dev, uint16_t qid);
>  
>  #endif /* ZXDH_ETHDEV_OPS_H */
> diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
> new file mode 100644
> index 0000000000..6540f4c088
> --- /dev/null
> +++ b/drivers/net/zxdh/zxdh_flow.c
> @@ -0,0 +1,2017 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 ZTE Corporation
> + */
> +
> +#include <sys/queue.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdarg.h>
> +#include <stdlib.h>
> +
> +#include <rte_debug.h>
> +#include <rte_ether.h>
> +#include <ethdev_driver.h>
> +#include <rte_log.h>
> +#include <rte_malloc.h>
> +#include <rte_tailq.h>
> +#include <rte_flow.h>
> +#include <rte_bitmap.h>
> +
> +#include "zxdh_ethdev.h"
> +#include "zxdh_logs.h"
> +#include "zxdh_flow.h"
> +#include "zxdh_tables.h"
> +#include "zxdh_ethdev_ops.h"
> +#include "zxdh_np.h"
> +#include "zxdh_msg.h"
> +
> +#define ZXDH_IPV6_FRAG_HEADER    44
> +#define ZXDH_TENANT_ARRAY_NUM    3
> +#define ZXDH_VLAN_TCI_MASK       0xFFFF
> +#define ZXDH_VLAN_PRI_MASK       0xE000
> +#define ZXDH_VLAN_CFI_MASK       0x1000
> +#define ZXDH_VLAN_VID_MASK       0x0FFF
> +#define MAX_STRING_LEN           8192
> +#define FLOW_INGRESS             0
> +#define FLOW_EGRESS              1
> +#define MAX_ENCAP1_NUM           (256)
> +#define INVALID_HANDLEIDX        0xffff
> +#define ACTION_VXLAN_ENCAP_ITEMS_NUM (6)
> +static struct dh_engine_list flow_engine_list = TAILQ_HEAD_INITIALIZER(flow_engine_list);
> +static struct count_res flow_count_ref[MAX_FLOW_COUNT_NUM];
> +static rte_spinlock_t fd_hw_res_lock = RTE_SPINLOCK_INITIALIZER;
> +static uint8_t fd_hwres_bitmap[ZXDH_MAX_FLOW_NUM] = {0};
> +
> +#define MKDUMPSTR(buf, buf_size, cur_len, ...) \
> +do { \
> +    if ((cur_len) >= (buf_size)) \
> +        break; \
> +    (cur_len) += snprintf((buf) + (cur_len), (buf_size) - (cur_len), __VA_ARGS__); \
> +} while (0)
> +
> +static inline void
> +print_ether_addr(const char *what, const struct rte_ether_addr *eth_addr,
> +         char print_buf[], uint32_t buf_size, uint32_t *cur_len)
> +{
> +    char buf[RTE_ETHER_ADDR_FMT_SIZE];
> +
> +    rte_ether_format_addr(buf, RTE_ETHER_ADDR_FMT_SIZE, eth_addr);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, "%s%s", what, buf);
> +}
> +
> +static inline void
> +zxdh_fd_flow_free_dtbentry(ZXDH_DTB_USER_ENTRY_T *dtb_entry)
> +{
> +    rte_free(dtb_entry->p_entry_data);
> +    dtb_entry->p_entry_data = NULL;
> +    dtb_entry->sdt_no = 0;
> +}
> +
> +static void
> +data_bitwise(void *data, int bytecnt)
> +{
> +    int i;
> +    uint32_t *temp = (uint32_t *)data;
> +    int remain = bytecnt % 4;
> +    for (i = 0; i < (bytecnt >> 2); i++)    {
> +        *(temp) = ~*(temp);
> +        temp++;
> +    }
> +
> +    if (remain) {
> +        for (i = 0; i < remain; i++) {
> +            uint8_t *tmp = (uint8_t *)temp;
> +            *(uint8_t *)tmp = ~*(uint8_t *)tmp;
> +            tmp++;
> +        }
> +    }
> +}
> +
> +static void
> +zxdh_adjust_flow_op_rsp_memory_layout(void *old_data,
> +        size_t old_size, void *new_data)
> +{
> +    rte_memcpy(new_data, old_data, sizeof(struct zxdh_flow));
> +    memset((char *)new_data + sizeof(struct zxdh_flow), 0, 4);
> +    rte_memcpy((char *)new_data + sizeof(struct zxdh_flow) + 4,
> +        (char *)old_data + sizeof(struct zxdh_flow),
> +        old_size - sizeof(struct zxdh_flow));
> +}
> +
> +void zxdh_flow_global_init(void)
> +{
> +    int i;
> +    for (i = 0; i < MAX_FLOW_COUNT_NUM; i++) {
> +        rte_spinlock_init(&flow_count_ref[i].count_lock);
> +        flow_count_ref[i].count_ref = 0;
> +    }
> +}
> +
> +static void
> +__entry_dump(char *print_buf, uint32_t buf_size,
> +        uint32_t *cur_len, struct fd_flow_key *key)
> +{
> +    print_ether_addr("\nL2\t  dst=", &key->mac_dst, print_buf, buf_size, cur_len);
> +    print_ether_addr(" - src=", &key->mac_src, print_buf, buf_size, cur_len);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -eth type=0x%04x", key->ether_type);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len,
> +        " -vlan_pri=0x%02x -vlan_vlanid=0x%04x  -vlan_tci=0x%04x ",
> +        key->cvlan_pri, key->cvlan_vlanid, key->vlan_tci);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len,
> +        " -vni=0x%02x 0x%02x 0x%02x\n", key->vni[0], key->vni[1], key->vni[2]);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len,
> +        "L3\t  dstip=0x%08x 0x%08x 0x%08x 0x%08x("IPv6_BYTES_FMT")\n",
> +        *(uint32_t *)key->dst_ip, *((uint32_t *)key->dst_ip + 1),
> +        *((uint32_t *)key->dst_ip + 2),
> +        *((uint32_t *)key->dst_ip + 3),
> +        IPv6_BYTES(key->dst_ip));
> +    MKDUMPSTR(print_buf, buf_size, *cur_len,
> +        "\t  srcip=0x%08x 0x%08x 0x%08x 0x%08x("IPv6_BYTES_FMT")\n",
> +        *((uint32_t *)key->src_ip), *((uint32_t *)key->src_ip + 1),
> +        *((uint32_t *)key->src_ip + 2),
> +        *((uint32_t *)key->src_ip + 3),
> +        IPv6_BYTES(key->src_ip));
> +    MKDUMPSTR(print_buf, buf_size, *cur_len,
> +        "  \t  tos=0x%02x -nw-proto=0x%02x -frag-flag %u\n",
> +        key->tos, key->nw_proto, key->frag_flag);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len,
> +        "L4\t  dstport=0x%04x -srcport=0x%04x", key->tp_dst, key->tp_src);
> +}
> +
> +static void
> +__result_dump(char *print_buf, uint32_t buf_size,
> +        uint32_t *cur_len, struct fd_flow_result *res)
> +{
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -hit_flag = 0x%04x", res->hit_flag);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -action_idx = 0x%02x", res->action_idx);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -qid = 0x%04x", res->qid);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -mark_id = 0x%08x", res->mark_fd_id);
> +    MKDUMPSTR(print_buf, buf_size, *cur_len, " -count_id = 0x%02x", res->countid);
> +}
> +
> +static void offlow_key_dump(struct fd_flow_key *key, struct fd_flow_key *key_mask, FILE *file)
> +{
> +    char print_buf[MAX_STRING_LEN];
> +    uint32_t buf_size = MAX_STRING_LEN;
> +    uint32_t cur_len = 0;
> +
> +    MKDUMPSTR(print_buf, buf_size, cur_len, "offload key:\n\t");
> +    __entry_dump(print_buf, buf_size, &cur_len, key);
> +
> +    MKDUMPSTR(print_buf, buf_size, cur_len, "\noffload key_mask:\n\t");
> +    __entry_dump(print_buf, buf_size, &cur_len, key_mask);
> +
> +    PMD_DRV_LOG(INFO, "%s", print_buf);
> +    MKDUMPSTR(print_buf, buf_size, cur_len, "\n");
> +    if (file)
> +        fputs(print_buf, file);
> +}
> +
> +static void offlow_result_dump(struct fd_flow_result *res, FILE *file)
> +{
> +    char print_buf[MAX_STRING_LEN];
> +    uint32_t buf_size = MAX_STRING_LEN;
> +    uint32_t cur_len = 0;
> +
> +    MKDUMPSTR(print_buf, buf_size, cur_len, "offload result:\n");
> +    __result_dump(print_buf, buf_size, &cur_len, res);
> +    PMD_DRV_LOG(INFO, "%s", print_buf);
> +    PMD_DRV_LOG(INFO, "memdump : ===result ===");
> +    MKDUMPSTR(print_buf, buf_size, cur_len, "\n");
> +    if (file)
> +        fputs(print_buf, file);
> +}
> +
> +static int
> +set_flow_enable(struct rte_eth_dev *dev, uint8_t dir,
> +        bool enable, struct rte_flow_error *error)
> +{
> +    struct zxdh_hw *priv = dev->data->dev_private;
> +    struct zxdh_port_attr_table port_attr = {0};
> +    int ret = 0;
> +
> +    if (priv->is_pf) {
> +        ret = zxdh_get_port_attr(priv, priv->vport.vport, &port_attr);
> +        if (ret)
> +            return -rte_flow_error_set(error, EINVAL,
> +                    RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                    "get port attr failed.");
> +        port_attr.fd_enable = enable;
> +
> +        ret = zxdh_set_port_attr(priv, priv->vport.vport, &port_attr);
> +        if (ret)
> +            return -rte_flow_error_set(error, EINVAL,
> +                    RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                    "set port attr fd_enable failed.");
> +    } else {
> +        struct zxdh_msg_info msg_info = {0};
> +        struct zxdh_port_attr_set_msg *attr_msg = &msg_info.data.port_attr_msg;
> +
> +        attr_msg->mode  = ZXDH_PORT_FD_EN_OFF_FLAG;
> +        attr_msg->value = enable;
> +        zxdh_msg_head_build(priv, ZXDH_PORT_ATTRS_SET, &msg_info);
> +        ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(msg_info), NULL, 0);
> +        if (ret) {
> +            PMD_DRV_LOG(ERR, "port %d flow enable failed", priv->port_id);
> +            return -rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                        "flow enable failed.");
> +        }
> +    }
> +    if (dir == FLOW_INGRESS)
> +        priv->i_flow_en = !!enable;
> +    else
> +        priv->e_flow_en = !!enable;
> +
> +    return ret;
> +}
> +
> +static int
> +set_vxlan_enable(struct rte_eth_dev *dev, bool enable, struct rte_flow_error *error)
> +{
> +    struct zxdh_hw *priv = dev->data->dev_private;
> +    struct zxdh_port_attr_table port_attr = {0};
> +    int ret = 0;
> +
> +    if (priv->vxlan_flow_en == !!enable)
> +        return 0;
> +    if (priv->is_pf) {
> +        ret = zxdh_get_port_attr(priv, priv->vport.vport, &port_attr);
> +        if (ret)
> +            return -rte_flow_error_set(error, EINVAL,
> +                    RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                    "get port attr failed.");
> +        port_attr.fd_vxlan_offload_en = enable;
> +
> +        ret = zxdh_set_port_attr(priv, priv->vport.vport, &port_attr);
> +        if (ret)
> +            return -rte_flow_error_set(error, EINVAL,
> +                    RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                    "set port attr fd_enable failed.");
> +    } else {
> +        struct zxdh_msg_info msg_info = {0};
> +        struct zxdh_port_attr_set_msg *attr_msg = &msg_info.data.port_attr_msg;
> +
> +        attr_msg->mode  = ZXDH_PORT_VXLAN_OFFLOAD_EN_OFF;
> +        attr_msg->value = enable;
> +
> +        zxdh_msg_head_build(priv, ZXDH_PORT_ATTRS_SET, &msg_info);
> +        ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(msg_info), NULL, 0);
> +        if (ret) {
> +            PMD_DRV_LOG(ERR, "port %d vxlan flow enable failed", priv->port_id);
> +            return -rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                        "vxlan offload enable failed.");
> +        }
> +    }
> +
> +    priv->vxlan_flow_en = !!enable;
> +    return ret;
> +}
> +
> +void zxdh_register_flow_engine(struct dh_flow_engine *engine)
> +{
> +    TAILQ_INSERT_TAIL(&flow_engine_list, engine, node);
> +}
> +
> +static void zxdh_flow_free(struct zxdh_flow *dh_flow)
> +{
> +    if (dh_flow)
> +        rte_mempool_put(zxdh_shared_data->flow_mp, dh_flow);
> +}
> +
> +static struct dh_flow_engine *zxdh_get_flow_engine(struct rte_eth_dev *dev __rte_unused)
> +{
> +    struct dh_flow_engine *engine = NULL;
> +    void *temp;
> +
> +    RTE_TAILQ_FOREACH_SAFE(engine, &flow_engine_list, node, temp) {
> +        if (engine->type  == FLOW_TYPE_FD_TCAM)
> +            break;
> +    }
> +    return engine;
> +}
> +
> +static int
> +zxdh_flow_validate(struct rte_eth_dev *dev,
> +             const struct rte_flow_attr *attr,
> +             const struct rte_flow_item  *pattern,
> +             const struct rte_flow_action *actions,
> +             struct rte_flow_error *error)
> +{
> +    struct dh_flow_engine *flow_engine = NULL;
> +
> +    if (!pattern) {
> +        rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
> +                   NULL, "NULL pattern.");
> +        return -rte_errno;
> +    }
> +
> +    if (!actions) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
> +                   NULL, "NULL action.");
> +        return -rte_errno;
> +    }
> +
> +    if (!attr) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_ATTR,
> +                   NULL, "NULL attribute.");
> +        return -rte_errno;
> +    }
> +    flow_engine = zxdh_get_flow_engine(dev);
> +    if (flow_engine == NULL || flow_engine->parse_pattern_action == NULL) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +                   NULL, "cannot find valid flow engine.");
> +        return -rte_errno;
> +    }
> +    if (flow_engine->parse_pattern_action(dev, attr, pattern, actions, error, NULL) != 0)
> +        return -rte_errno;
> +    return 0;
> +}
> +
> +static struct zxdh_flow *flow_exist_check(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow)
> +{
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    struct rte_flow *entry;
> +    struct zxdh_flow *entry_flow;
> +
> +    TAILQ_FOREACH(entry, &hw->dh_flow_list, next) {
> +        entry_flow = (struct zxdh_flow *)entry->driver_flow;
> +        if ((memcmp(&entry_flow->flowentry.fd_flow.key, &dh_flow->flowentry.fd_flow.key,
> +                 sizeof(struct fd_flow_key)) == 0)  &&
> +            (memcmp(&entry_flow->flowentry.fd_flow.key_mask,
> +                &dh_flow->flowentry.fd_flow.key_mask,
> +                 sizeof(struct fd_flow_key)) == 0)) {
> +            return entry_flow;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static struct rte_flow *
> +zxdh_flow_create(struct rte_eth_dev *dev,
> +         const struct rte_flow_attr *attr,
> +         const struct rte_flow_item pattern[],
> +         const struct rte_flow_action actions[],
> +         struct rte_flow_error *error)
> +{
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    struct rte_flow *flow = NULL;
> +    struct zxdh_flow *dh_flow = NULL;
> +    int ret = 0;
> +    struct dh_flow_engine *flow_engine = NULL;
> +
> +    flow_engine = zxdh_get_flow_engine(dev);
> +
> +    if (flow_engine == NULL ||
> +        flow_engine->parse_pattern_action == NULL ||
> +        flow_engine->apply == NULL) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +                   NULL, "cannot find valid flow engine.");
> +        return NULL;
> +    }
> +
> +    flow = rte_zmalloc("rte_flow", sizeof(struct rte_flow), 0);
> +    if (!flow) {
> +        rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, "flow malloc failed");
> +        return NULL;
> +    }
> +    ret = rte_mempool_get(zxdh_shared_data->flow_mp, (void **)&dh_flow);
> +    if (ret) {
> +        rte_flow_error_set(error, ENOMEM,
> +                   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                    "Failed to allocate memory from flowmp");
> +        goto free_flow;
> +    }
> +    memset(dh_flow, 0, sizeof(struct zxdh_flow));
> +    if (flow_engine->parse_pattern_action(dev, attr, pattern, actions, error, dh_flow) != 0) {
> +        PMD_DRV_LOG(ERR, "parse_pattern_action failed zxdh_created failed");
> +        goto free_flow;
> +    }
> +
> +    if (flow_exist_check(dev, dh_flow) != NULL) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                    "duplicate entry: will not add");
> +        goto free_flow;
> +    }
> +
> +    ret = flow_engine->apply(dev, dh_flow, error, hw->vport.vport, hw->pcie_id);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "flow creation failed: failed to apply");
> +        goto free_flow;
> +    }
> +    flow->driver_flow = dh_flow;
> +    flow->port_id = dev->data->port_id;
> +    flow->type = ZXDH_FLOW_GROUP_TCAM;
> +    TAILQ_INSERT_TAIL(&hw->dh_flow_list, flow, next);
> +
> +    if (hw->i_flow_en == 0) {
> +        ret = set_flow_enable(dev, FLOW_INGRESS, 1, error);
> +        if (ret < 0) {

Still no need to remove the item from the list? May be I'm missing something?

Thank you.

> +            PMD_DRV_LOG(ERR, "set flow enable failed");
> +            goto free_flow;
> +        }
> +    }
> +    return flow;
> +free_flow:
> +    zxdh_flow_free(dh_flow);
> +    rte_free(flow);
> +    return NULL;
> +}
> +
> +static int
> +zxdh_flow_destroy(struct rte_eth_dev *dev,
> +          struct rte_flow *flow,
> +          struct rte_flow_error *error)
> +{
> +    struct zxdh_hw *priv = dev->data->dev_private;
> +    struct zxdh_flow *dh_flow = NULL;
> +    int ret = 0;
> +    struct dh_flow_engine *flow_engine = NULL;
> +
> +    flow_engine = zxdh_get_flow_engine(dev);
> +    if (flow_engine == NULL ||
> +        flow_engine->destroy == NULL) {
> +        rte_flow_error_set(error, EINVAL,
> +                 RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +                 NULL, "cannot find valid flow engine.");
> +        return -rte_errno;
> +    }
> +    if (flow->driver_flow)
> +        dh_flow = (struct zxdh_flow *)flow->driver_flow;
> +
> +    if (dh_flow == NULL) {
> +        PMD_DRV_LOG(ERR, "invalid flow");
> +        rte_flow_error_set(error, EINVAL,
> +                 RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +                 NULL, "invalid flow");
> +        return -1;
> +    }
> +    ret = flow_engine->destroy(dev, dh_flow, error, priv->vport.vport, priv->pcie_id);
> +    if (ret) {
> +        rte_flow_error_set(error, -ret,
> +                   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                   "Failed to destroy flow.");
> +        return -rte_errno;
> +    }
> +    TAILQ_REMOVE(&priv->dh_flow_list, flow, next);
> +    zxdh_flow_free(dh_flow);
> +    rte_free(flow);
> +
> +    if (TAILQ_EMPTY(&priv->dh_flow_list)) {
> +        ret = set_flow_enable(dev, FLOW_INGRESS, 0, error);
> +        if (ret) {
> +            PMD_DRV_LOG(ERR, "clear flow enable failed");
> +            return -rte_errno;
> +        }
> +    }
> +    return ret;
> +}
> +
> +
> +static int
> +zxdh_flow_query(struct rte_eth_dev *dev,
> +        struct rte_flow *flow,
> +        const struct rte_flow_action *actions,
> +        void *data, struct rte_flow_error *error)
> +{
> +    struct zxdh_flow *dh_flow = NULL;
> +    struct dh_flow_engine *flow_engine = NULL;
> +    int ret = 0;
> +
> +    flow_engine = zxdh_get_flow_engine(dev);
> +
> +    if (flow_engine == NULL ||
> +        flow_engine->query_count == NULL) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
> +                   NULL, "cannot find valid flow engine.");
> +        return -rte_errno;
> +    }
> +
> +    if (flow->driver_flow) {
> +        dh_flow = (struct zxdh_flow *)flow->driver_flow;
> +        if (dh_flow == NULL) {
> +            PMD_DRV_LOG(ERR, "flow does not exist");
> +            return -1;
> +        }
> +    }
> +
> +    for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
> +        switch (actions->type) {
> +        case RTE_FLOW_ACTION_TYPE_VOID:
> +            break;
> +        case RTE_FLOW_ACTION_TYPE_COUNT:
> +            ret = flow_engine->query_count(dev, dh_flow,
> +                         (struct rte_flow_query_count *)data, error);
> +            break;
> +        default:
> +            ret = rte_flow_error_set(error, ENOTSUP,
> +                    RTE_FLOW_ERROR_TYPE_ACTION,
> +                    actions,
> +                    "action does not support QUERY");
> +            goto out;
> +        }
> +    }
> +out:
> +    if (ret)
> +        PMD_DRV_LOG(ERR, "flow query failed");
> +    return ret;
> +}
> +
> +static int zxdh_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
> +{
> +    struct rte_flow *flow;
> +    struct zxdh_flow *dh_flow = NULL;
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    struct zxdh_dtb_shared_data *dtb_data = &hw->dev_sd->dtb_sd;
> +    struct dh_flow_engine *flow_engine = NULL;
> +    struct zxdh_msg_info msg_info = {0};
> +    uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +    int ret = 0;
> +
> +    flow_engine = zxdh_get_flow_engine(dev);
> +    if (flow_engine == NULL) {
> +        PMD_DRV_LOG(ERR, "get flow engine failed");
> +        return -1;
> +    }
> +    ret = set_flow_enable(dev, FLOW_INGRESS, 0, error);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "clear flow enable failed");
> +        return ret;
> +    }
> +
> +    ret = set_vxlan_enable(dev, 0, error);
> +    if (ret)
> +        PMD_DRV_LOG(ERR, "clear vxlan enable failed");
> +    hw->vxlan_fd_num = 0;
> +
> +    if (hw->is_pf) {
> +        ret = zxdh_np_dtb_acl_offline_delete(hw->dev_id, dtb_data->queueid,
> +                    ZXDH_SDT_FD_TABLE, hw->vport.vport,
> +                    ZXDH_FLOW_STATS_INGRESS_BASE, 1);
> +        if (ret)
> +            PMD_DRV_LOG(ERR, "%s flush failed. code:%d", dev->data->name, ret);
> +    } else {
> +        zxdh_msg_head_build(hw, ZXDH_FLOW_HW_FLUSH, &msg_info);
> +        ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
> +            (void *)zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
> +        if (ret) {
> +            PMD_DRV_LOG(ERR, "port %d flow op %d flush failed ret %d",
> +                hw->port_id, ZXDH_FLOW_HW_FLUSH, ret);
> +            return -1;
> +        }
> +    }
> +
> +    /* Remove all flows */
> +    while ((flow = TAILQ_FIRST(&hw->dh_flow_list))) {
> +        TAILQ_REMOVE(&hw->dh_flow_list, flow, next);
> +        if (flow->driver_flow)
> +            dh_flow = (struct zxdh_flow *)flow->driver_flow;
> +        if (dh_flow == NULL) {
> +            PMD_DRV_LOG(ERR, "Invalid flow Failed to destroy flow.");
> +            ret = rte_flow_error_set(error, ENOTSUP,
> +                    RTE_FLOW_ERROR_TYPE_HANDLE,
> +                    NULL,
> +                    "Invalid flow, flush failed");
> +            return ret;
> +        }
> +
> +        zxdh_flow_free(dh_flow);
> +        rte_free(flow);
> +    }
> +    return ret;
> +}
> +
> +static void
> +handle_res_dump(struct rte_eth_dev *dev)
> +{
> +    struct zxdh_hw *priv =  dev->data->dev_private;
> +    uint16_t hwres_base = priv->vport.pfid << 10;
> +    uint16_t hwres_cnt = ZXDH_MAX_FLOW_NUM >> 1;
> +    uint16_t i;
> +
> +    PMD_DRV_LOG(DEBUG, "hwres_base %d", hwres_base);
> +    rte_spinlock_lock(&fd_hw_res_lock);
> +    for (i = 0; i < hwres_cnt; i++) {
> +        if (fd_hwres_bitmap[hwres_base + i] == 1)
> +            PMD_DRV_LOG(DEBUG, "used idx %d", i + hwres_base);
> +    }
> +    rte_spinlock_unlock(&fd_hw_res_lock);
> +}
> +
> +static int
> +zxdh_flow_dev_dump(struct rte_eth_dev *dev,
> +            struct rte_flow *flow,
> +            FILE *file,
> +            struct rte_flow_error *error __rte_unused)
> +{
> +    struct zxdh_hw *hw =  dev->data->dev_private;
> +    struct rte_flow *entry;
> +    struct zxdh_flow *entry_flow;
> +    uint32_t dtb_qid = 0;
> +    uint32_t entry_num = 0;
> +    uint16_t ret = 0;
> +    ZXDH_DTB_ACL_ENTRY_INFO_T *fd_entry = NULL;
> +    uint8_t *key = NULL;
> +    uint8_t *key_mask = NULL;
> +    uint8_t *result = NULL;
> +
> +    if (flow) {
> +        entry_flow = flow_exist_check(dev, (struct zxdh_flow *)flow->driver_flow);
> +        if (entry_flow) {
> +            PMD_DRV_LOG(DEBUG, "handle idx %d:", entry_flow->flowentry.hw_idx);
> +            offlow_key_dump(&entry_flow->flowentry.fd_flow.key,
> +                &entry_flow->flowentry.fd_flow.key_mask, file);
> +            offlow_result_dump(&entry_flow->flowentry.fd_flow.result, file);
> +        }
> +    } else {
> +        if (hw->is_pf) {
> +            dtb_qid = hw->dev_sd->dtb_sd.queueid;
> +            fd_entry = calloc(1, sizeof(ZXDH_DTB_ACL_ENTRY_INFO_T) * ZXDH_MAX_FLOW_NUM);
> +            key = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
> +            key_mask = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
> +            result = calloc(1, sizeof(struct fd_flow_result) * ZXDH_MAX_FLOW_NUM);
> +            if (!fd_entry || !key || !key_mask || !result) {
> +                PMD_DRV_LOG(ERR, "fd_entry malloc failed!");
> +                goto end;
> +            }
> +
> +            for (int i = 0; i < ZXDH_MAX_FLOW_NUM; i++) {
> +                fd_entry[i].key_data = key + i * sizeof(struct fd_flow_key);
> +                fd_entry[i].key_mask = key_mask + i * sizeof(struct fd_flow_key);
> +                fd_entry[i].p_as_rslt = result + i * sizeof(struct fd_flow_result);
> +            }
> +            ret = zxdh_np_dtb_acl_table_dump_by_vport(hw->dev_id, dtb_qid,
> +                        ZXDH_SDT_FD_TABLE, hw->vport.vport, &entry_num,
> +                        (uint8_t *)fd_entry);
> +            if (ret) {
> +                PMD_DRV_LOG(ERR, "dpp_dtb_acl_table_dump_by_vport failed!");
> +                goto end;
> +            }
> +            for (uint32_t i = 0; i < entry_num; i++) {
> +                offlow_key_dump((struct fd_flow_key *)fd_entry[i].key_data,
> +                    (struct fd_flow_key *)fd_entry[i].key_mask, file);
> +                offlow_result_dump((struct fd_flow_result *)fd_entry[i].p_as_rslt,
> +                        file);
> +            }
> +            free(result);
> +            free(key_mask);
> +            free(key);
> +            free(fd_entry);
> +        } else {
> +            entry = calloc(1, sizeof(struct rte_flow));
> +            entry_flow = calloc(1, sizeof(struct zxdh_flow));
> +            TAILQ_FOREACH(entry, &hw->dh_flow_list, next) {
> +                entry_flow = (struct zxdh_flow *)entry->driver_flow;
> +                offlow_key_dump(&entry_flow->flowentry.fd_flow.key,
> +                        &entry_flow->flowentry.fd_flow.key_mask, file);
> +                offlow_result_dump(&entry_flow->flowentry.fd_flow.result, file);
> +            }
> +            free(entry_flow);
> +            free(entry);
> +        }
> +    }
> +    handle_res_dump(dev);
> +
> +    return 0;
> +end:
> +    free(result);
> +    free(key_mask);
> +    free(key);
> +    free(fd_entry);
> +    return -1;
> +}
> +
> +static int32_t
> +get_available_handle(struct zxdh_hw *hw, uint16_t vport)
> +{
> +    int ret = 0;
> +    uint32_t handle_idx = 0;
> +
> +    ret = zxdh_np_dtb_acl_index_request(hw->dev_id, ZXDH_SDT_FD_TABLE, vport, &handle_idx);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "Failed to allocate memory for hw!");
> +        return INVALID_HANDLEIDX;
> +    }
> +    return handle_idx;
> +}
> +
> +static int free_handle(struct zxdh_hw *hw, uint16_t handle_idx, uint16_t vport)
> +{
> +    int ret = zxdh_np_dtb_acl_index_release(hw->dev_id, ZXDH_SDT_FD_TABLE, vport, handle_idx);
> +
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "Failed to free handle_idx %d for hw!", handle_idx);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static uint16_t
> +zxdh_encap0_to_dtbentry(struct zxdh_hw *hw __rte_unused,
> +            struct zxdh_flow *dh_flow,
> +            ZXDH_DTB_USER_ENTRY_T *dtb_entry)
> +{
> +    ZXDH_DTB_ERAM_ENTRY_INFO_T *dtb_eram_entry;
> +    dtb_eram_entry = rte_zmalloc(NULL, sizeof(ZXDH_DTB_ERAM_ENTRY_INFO_T), 0);
> +
> +    if (dtb_eram_entry == NULL)
> +        return INVALID_HANDLEIDX;
> +
> +    dtb_eram_entry->index = dh_flow->flowentry.fd_flow.result.encap0_index * 2;
> +    dtb_eram_entry->p_data = (uint32_t *)&dh_flow->encap0;
> +
> +    dtb_entry->sdt_no = ZXDH_SDT_TUNNEL_ENCAP0_TABLE;
> +    dtb_entry->p_entry_data = dtb_eram_entry;
> +    return 0;
> +}
> +
> +static uint16_t
> +zxdh_encap0_ip_to_dtbentry(struct zxdh_hw *hw __rte_unused,
> +            struct zxdh_flow *dh_flow,
> +            ZXDH_DTB_USER_ENTRY_T *dtb_entry)
> +{
> +    ZXDH_DTB_ERAM_ENTRY_INFO_T *dtb_eram_entry;
> +    dtb_eram_entry = rte_zmalloc(NULL, sizeof(ZXDH_DTB_ERAM_ENTRY_INFO_T), 0);
> +
> +    if (dtb_eram_entry == NULL)
> +        return INVALID_HANDLEIDX;
> +
> +    dtb_eram_entry->index = dh_flow->flowentry.fd_flow.result.encap0_index * 2 + 1;
> +    dtb_eram_entry->p_data = (uint32_t *)&dh_flow->encap0.dip;
> +    dtb_entry->sdt_no = ZXDH_SDT_TUNNEL_ENCAP0_TABLE;
> +    dtb_entry->p_entry_data = dtb_eram_entry;
> +    return 0;
> +}
> +
> +static uint16_t zxdh_encap1_to_dtbentry(struct zxdh_hw *hw __rte_unused,
> +                             struct zxdh_flow *dh_flow,
> +                             ZXDH_DTB_USER_ENTRY_T *dtb_entry)
> +{
> +    ZXDH_DTB_ERAM_ENTRY_INFO_T *dtb_eram_entry;
> +    dtb_eram_entry = rte_zmalloc(NULL, sizeof(ZXDH_DTB_ERAM_ENTRY_INFO_T), 0);
> +
> +    if (dtb_eram_entry == NULL)
> +        return INVALID_HANDLEIDX;
> +
> +    if (dh_flow->encap0.ethtype == 0)
> +        dtb_eram_entry->index = dh_flow->flowentry.fd_flow.result.encap1_index * 4;
> +    else
> +        dtb_eram_entry->index = dh_flow->flowentry.fd_flow.result.encap1_index * 4 + 1;
> +
> +    dtb_eram_entry->p_data = (uint32_t *)&dh_flow->encap1;
> +
> +    dtb_entry->sdt_no = ZXDH_SDT_TUNNEL_ENCAP1_TABLE;
> +    dtb_entry->p_entry_data = dtb_eram_entry;
> +    return 0;
> +}
> +
> +static uint16_t
> +zxdh_encap1_ip_to_dtbentry(struct zxdh_hw *hw __rte_unused,
> +            struct zxdh_flow *dh_flow,
> +            ZXDH_DTB_USER_ENTRY_T *dtb_entry)
> +{
> +    ZXDH_DTB_ERAM_ENTRY_INFO_T *dtb_eram_entry;
> +    dtb_eram_entry = rte_zmalloc(NULL, sizeof(ZXDH_DTB_ERAM_ENTRY_INFO_T), 0);
> +
> +    if (dtb_eram_entry == NULL)
> +        return INVALID_HANDLEIDX;
> +    if (dh_flow->encap0.ethtype == 0)
> +        dtb_eram_entry->index = dh_flow->flowentry.fd_flow.result.encap1_index * 4 + 2;
> +    else
> +        dtb_eram_entry->index = dh_flow->flowentry.fd_flow.result.encap1_index * 4 + 3;
> +    dtb_eram_entry->p_data = (uint32_t *)&dh_flow->encap1.sip;
> +    dtb_entry->sdt_no = ZXDH_SDT_TUNNEL_ENCAP1_TABLE;
> +    dtb_entry->p_entry_data = dtb_eram_entry;
> +    return 0;
> +}
> +
> +static int zxdh_hw_encap_insert(struct rte_eth_dev *dev,
> +                    struct zxdh_flow *dh_flow,
> +                    struct rte_flow_error *error)
> +{
> +    uint32_t ret;
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    uint32_t dtb_qid = hw->dev_sd->dtb_sd.queueid;
> +    ZXDH_DTB_USER_ENTRY_T dtb_entry = {0};
> +
> +    zxdh_encap0_to_dtbentry(hw, dh_flow, &dtb_entry);
> +    ret = zxdh_np_dtb_table_entry_write(hw->dev_id, dtb_qid, 1, &dtb_entry);
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                            RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                            "write to hw failed");
> +        return -1;
> +    }
> +
> +    zxdh_encap0_ip_to_dtbentry(hw, dh_flow, &dtb_entry);
> +    ret = zxdh_np_dtb_table_entry_write(hw->dev_id, dtb_qid, 1, &dtb_entry);
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                "write to hw failed");
> +        return -1;
> +    }
> +
> +    zxdh_encap1_to_dtbentry(hw, dh_flow, &dtb_entry);
> +    ret = zxdh_np_dtb_table_entry_write(hw->dev_id, dtb_qid, 1, &dtb_entry);
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                    RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                    "write to hw failed");
> +        return -1;
> +    }
> +
> +    zxdh_encap1_ip_to_dtbentry(hw, dh_flow, &dtb_entry);
> +    ret = zxdh_np_dtb_table_entry_write(hw->dev_id, dtb_qid, 1, &dtb_entry);
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                    RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                    "write to hw failed");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static uint16_t
> +zxdh_fd_flow_to_dtbentry(struct zxdh_hw *hw __rte_unused,
> +        struct zxdh_flow_info *fdflow,
> +        ZXDH_DTB_USER_ENTRY_T *dtb_entry)
> +{
> +    ZXDH_DTB_ACL_ENTRY_INFO_T *dtb_acl_entry;
> +    uint16_t handle_idx = 0;
> +    dtb_acl_entry = rte_zmalloc("fdflow_dtbentry", sizeof(ZXDH_DTB_ACL_ENTRY_INFO_T), 0);
> +
> +    if (dtb_acl_entry == NULL)
> +        return INVALID_HANDLEIDX;
> +
> +    dtb_acl_entry->key_data = (uint8_t *)&fdflow->fd_flow.key;
> +    dtb_acl_entry->key_mask = (uint8_t *)&fdflow->fd_flow.key_mask;
> +    dtb_acl_entry->p_as_rslt = (uint8_t *)&fdflow->fd_flow.result;
> +
> +    handle_idx = fdflow->hw_idx;
> +
> +    if (handle_idx >= ZXDH_MAX_FLOW_NUM) {
> +        rte_free(dtb_acl_entry);
> +        return INVALID_HANDLEIDX;
> +    }
> +    dtb_acl_entry->handle = handle_idx;
> +    dtb_entry->sdt_no = ZXDH_SDT_FD_TABLE;
> +    dtb_entry->p_entry_data = dtb_acl_entry;
> +    return handle_idx;
> +}
> +
> +static int zxdh_hw_flow_insert(struct rte_eth_dev *dev,
> +                                struct zxdh_flow *dh_flow,
> +                                struct rte_flow_error *error,
> +                                uint16_t vport)
> +{
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    uint32_t dtb_qid = hw->dev_sd->dtb_sd.queueid;
> +    ZXDH_DTB_USER_ENTRY_T dtb_entry = {0};
> +    uint32_t ret;
> +    uint16_t handle_idx;
> +
> +    struct zxdh_flow_info *flow = &dh_flow->flowentry;
> +    handle_idx = zxdh_fd_flow_to_dtbentry(hw, flow, &dtb_entry);
> +    if (handle_idx == INVALID_HANDLEIDX) {
> +        rte_flow_error_set(error, EINVAL,
> +                         RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                         "Failed to allocate memory for hw");
> +        return -1;
> +    }
> +    ret = zxdh_np_dtb_table_entry_write(hw->dev_id, dtb_qid, 1, &dtb_entry);
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    if (ret) {
> +        ret = free_handle(hw, handle_idx, vport);
> +        if (ret) {
> +            rte_flow_error_set(error, EINVAL,
> +                         RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                         "release handle_idx to hw failed");
> +            return -1;
> +        }
> +        rte_flow_error_set(error, EINVAL,
> +                         RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                         "write to hw failed");
> +        return -1;
> +    }
> +    dh_flow->flowentry.hw_idx = handle_idx;
> +    return 0;
> +}
> +
> +static int
> +hw_count_query(struct zxdh_hw *hw, uint32_t countid, bool clear,
> +        struct flow_stats *fstats, struct rte_flow_error *error)
> +{
> +    uint32_t stats_id = 0;
> +    int ret = 0;
> +    stats_id = countid;
> +    if (stats_id >= ZXDH_MAX_FLOW_NUM) {
> +        PMD_DRV_LOG(DEBUG, "query count id %d invalid", stats_id);
> +        ret = rte_flow_error_set(error, ENODEV,
> +                 RTE_FLOW_ERROR_TYPE_HANDLE,
> +                 NULL,
> +                 "query count id invalid");
> +        return -rte_errno;
> +    }
> +    PMD_DRV_LOG(DEBUG, "query count id %d,clear %d ", stats_id, clear);
> +    if (!clear)
> +        ret = zxdh_np_dtb_stats_get(hw->dev_id, hw->dev_sd->dtb_sd.queueid, 1,
> +                    stats_id + ZXDH_FLOW_STATS_INGRESS_BASE,
> +                    (uint32_t *)fstats);
> +    else
> +        ret = zxdh_np_stat_ppu_cnt_get_ex(hw->dev_id, 1,
> +                    stats_id + ZXDH_FLOW_STATS_INGRESS_BASE,
> +                    1, (uint32_t *)fstats);
> +    if (ret)
> +        rte_flow_error_set(error, EINVAL,
> +                 RTE_FLOW_ERROR_TYPE_ACTION, NULL,
> +                     "fail to get flow stats");
> +    return ret;
> +}
> +
> +static int
> +count_deref(struct zxdh_hw *hw, uint32_t countid,
> +        struct rte_flow_error *error)
> +{
> +    int ret = 0;
> +    struct count_res *count_res = &flow_count_ref[countid];
> +    struct flow_stats fstats = {0};
> +
> +    rte_spinlock_lock(&count_res->count_lock);
> +
> +    if (count_res->count_ref >= 1) {
> +        count_res->count_ref--;
> +    } else {
> +        rte_spinlock_unlock(&count_res->count_lock);
> +        return rte_flow_error_set(error, ENOTSUP,
> +                     RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                     NULL,
> +                     "count deref underflow");
> +    }
> +    if (count_res->count_ref == 0)
> +        ret = hw_count_query(hw, countid, 1, &fstats, error);
> +
> +    rte_spinlock_unlock(&count_res->count_lock);
> +    return ret;
> +}
> +
> +static int
> +count_ref(struct zxdh_hw *hw, uint32_t countid, struct rte_flow_error *error)
> +{
> +    int ret = 0;
> +    struct count_res *count_res = &flow_count_ref[countid];
> +    struct flow_stats fstats = {0};
> +
> +    rte_spinlock_lock(&count_res->count_lock);
> +    if (count_res->count_ref < 255) {
> +        count_res->count_ref++;
> +    } else {
> +        rte_spinlock_unlock(&count_res->count_lock);
> +        return rte_flow_error_set(error, ENOTSUP,
> +                     RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                     NULL,
> +                     "count ref overflow");
> +    }
> +
> +    if (count_res->count_ref == 1)
> +        ret = hw_count_query(hw, countid, 1, &fstats, error);
> +
> +    rte_spinlock_unlock(&count_res->count_lock);
> +    return ret;
> +}
> +
> +int
> +pf_fd_hw_apply(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +        struct rte_flow_error *error, uint16_t vport, uint16_t pcieid)
> +{
> +    int ret = 0;
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    uint8_t vf_index = 0;
> +    uint8_t action_bits = dh_flow->flowentry.fd_flow.result.action_idx;
> +    uint32_t countid  = MAX_FLOW_COUNT_NUM;
> +    uint32_t handle_idx = 0;
> +    union zxdh_virport_num port = {0};
> +
> +    port.vport = vport;
> +    handle_idx = get_available_handle(hw, vport);
> +    if (handle_idx >= ZXDH_MAX_FLOW_NUM) {
> +        rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE, NULL, "Failed to allocate memory for hw");
> +        return -1;
> +    }
> +    dh_flow->flowentry.hw_idx = handle_idx;
> +    if ((action_bits & (1 << FD_ACTION_COUNT_BIT)) != 0) {
> +        countid = handle_idx;
> +        dh_flow->flowentry.fd_flow.result.countid = countid;
> +    }
> +
> +    if ((action_bits & (1 << FD_ACTION_VXLAN_ENCAP)) != 0) {
> +        dh_flow->flowentry.fd_flow.result.encap0_index = handle_idx;
> +        if (!port.vf_flag) {
> +            dh_flow->flowentry.fd_flow.result.encap1_index =
> +                hw->hash_search_index * MAX_ENCAP1_NUM;
> +        } else {
> +            vf_index = VF_IDX(pcieid);
> +            if (vf_index < (ZXDH_MAX_VF - 1)) {
> +                dh_flow->flowentry.fd_flow.result.encap1_index =
> +                    hw->hash_search_index * MAX_ENCAP1_NUM + vf_index + 1;
> +            } else {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                        "encap1 vf_index is too big");
> +                return -1;
> +            }
> +        }
> +        PMD_DRV_LOG(DEBUG, "encap_index (%d)(%d)",
> +                dh_flow->flowentry.fd_flow.result.encap0_index,
> +                dh_flow->flowentry.fd_flow.result.encap1_index);
> +        if (zxdh_hw_encap_insert(dev, dh_flow, error) != 0)
> +            return -1;
> +    }
> +    ret = zxdh_hw_flow_insert(dev, dh_flow, error, vport);
> +    if (!ret && countid < MAX_FLOW_COUNT_NUM)
> +        ret = count_ref(hw, countid, error);
> +
> +    if (!ret) {
> +        if (!port.vf_flag) {
> +            if (((action_bits & (1 << FD_ACTION_VXLAN_ENCAP)) != 0) ||
> +                ((action_bits & (1 << FD_ACTION_VXLAN_DECAP)) != 0)) {
> +                hw->vxlan_fd_num++;
> +                if (hw->vxlan_fd_num == 1)
> +                    set_vxlan_enable(dev, 1, error);
> +            }
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static int
> +zxdh_hw_flow_del(struct rte_eth_dev *dev,
> +                            struct zxdh_flow *dh_flow,
> +                            struct rte_flow_error *error,
> +                            uint16_t vport)
> +{
> +    struct zxdh_flow_info *flow = &dh_flow->flowentry;
> +    ZXDH_DTB_USER_ENTRY_T dtb_entry = {0};
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    uint32_t dtb_qid = hw->dev_sd->dtb_sd.queueid;
> +    uint32_t ret;
> +    uint16_t handle_idx;
> +
> +    handle_idx = zxdh_fd_flow_to_dtbentry(hw, flow, &dtb_entry);
> +    if (handle_idx >= ZXDH_MAX_FLOW_NUM) {
> +        rte_flow_error_set(error, EINVAL,
> +                         RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                         "Failed to allocate memory for hw");
> +        return -1;
> +    }
> +    ret = zxdh_np_dtb_table_entry_delete(hw->dev_id, dtb_qid, 1, &dtb_entry);
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                         RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                         "delete to hw failed");
> +        return -1;
> +    }
> +    ret = free_handle(hw, handle_idx, vport);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                        "release handle_idx to hw failed");
> +        return -1;
> +    }
> +    PMD_DRV_LOG(DEBUG, "release handle_idx to hw success! %d", handle_idx);
> +    return ret;
> +}
> +
> +int
> +pf_fd_hw_destroy(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +        struct rte_flow_error *error, uint16_t vport,
> +        uint16_t pcieid __rte_unused)
> +{
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    union zxdh_virport_num port = {0};
> +    int ret = 0;
> +
> +    port.vport = vport;
> +    ret = zxdh_hw_flow_del(dev, dh_flow, error, vport);
> +    PMD_DRV_LOG(DEBUG, "destroy handle id %d", dh_flow->flowentry.hw_idx);
> +    if (!ret) {
> +        uint8_t action_bits = dh_flow->flowentry.fd_flow.result.action_idx;
> +        uint32_t countid;
> +        countid = dh_flow->flowentry.hw_idx;
> +        if ((action_bits & (1 << FD_ACTION_COUNT_BIT)) != 0)
> +            ret = count_deref(hw, countid, error);
> +        if (!port.vf_flag) {
> +            if (((action_bits & (1 << FD_ACTION_VXLAN_ENCAP)) != 0) ||
> +                ((action_bits & (1 << FD_ACTION_VXLAN_DECAP)) != 0)) {
> +                hw->vxlan_fd_num--;
> +                if (hw->vxlan_fd_num == 0)
> +                    set_vxlan_enable(dev, 0, error);
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
> +static int
> +zxdh_hw_flow_query(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +        struct rte_flow_error *error)
> +{
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    int ret = 0;
> +    struct zxdh_flow_info *flow = &dh_flow->flowentry;
> +    ZXDH_DTB_USER_ENTRY_T dtb_entry;
> +    uint16_t handle_idx;
> +
> +    handle_idx = zxdh_fd_flow_to_dtbentry(hw, flow, &dtb_entry);
> +    if (handle_idx >= ZXDH_MAX_FLOW_NUM) {
> +        rte_flow_error_set(error, EINVAL,
> +                RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                "Failed to build hw entry for query");
> +        ret = -1;
> +        goto free_res;
> +    }
> +    ret = zxdh_np_dtb_table_entry_get(hw->dev_id, hw->dev_sd->dtb_sd.queueid, &dtb_entry, 0);
> +    if (ret != 0) {
> +        rte_flow_error_set(error, EINVAL,
> +                RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                "Failed query  entry from hw ");
> +        goto free_res;
> +    }
> +
> +free_res:
> +    zxdh_fd_flow_free_dtbentry(&dtb_entry);
> +    return ret;
> +}
> +
> +int
> +pf_fd_hw_query_count(struct rte_eth_dev *dev,
> +            struct zxdh_flow *flow,
> +            struct rte_flow_query_count *count,
> +            struct rte_flow_error *error)
> +{
> +    struct zxdh_hw *hw =  dev->data->dev_private;
> +    struct flow_stats  fstats = {0};
> +    int ret = 0;
> +    uint32_t countid;
> +
> +    memset(&flow->flowentry.fd_flow.result, 0, sizeof(struct fd_flow_result));
> +    ret = zxdh_hw_flow_query(dev, flow, error);
> +    if (ret) {
> +        ret = rte_flow_error_set(error, ENODEV,
> +                 RTE_FLOW_ERROR_TYPE_HANDLE,
> +                 NULL,
> +                 "query failed");
> +        return -rte_errno;
> +    }
> +    countid = flow->flowentry.hw_idx;
> +    if (countid >= ZXDH_MAX_FLOW_NUM) {
> +        ret = rte_flow_error_set(error, ENODEV,
> +                 RTE_FLOW_ERROR_TYPE_HANDLE,
> +                 NULL,
> +                 "query count id invalid");
> +        return -rte_errno;
> +    }
> +    ret = hw_count_query(hw, countid, 0, &fstats, error);
> +    if (ret) {
> +        rte_flow_error_set(error, EINVAL,
> +                 RTE_FLOW_ERROR_TYPE_ACTION, NULL,
> +                     "fail to get flow stats");
> +            return ret;
> +    }
> +    count->bytes = (uint64_t)(rte_le_to_cpu_32(fstats.hit_bytes_hi)) << 32 |
> +                    rte_le_to_cpu_32(fstats.hit_bytes_lo);
> +    count->hits = (uint64_t)(rte_le_to_cpu_32(fstats.hit_pkts_hi)) << 32 |
> +                    rte_le_to_cpu_32(fstats.hit_pkts_lo);
> +    return ret;
> +}
> +
> +static int
> +fd_flow_parse_attr(struct rte_eth_dev *dev __rte_unused,
> +        const struct rte_flow_attr *attr,
> +        struct rte_flow_error *error,
> +        struct zxdh_flow *dh_flow)
> +{
> +    /* Not supported */
> +    if (attr->priority) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
> +                   attr, "Not support priority.");
> +        return -rte_errno;
> +    }
> +
> +    /* Not supported */
> +    if (attr->group >= MAX_GROUP) {
> +        rte_flow_error_set(error, EINVAL,
> +                   RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
> +                   attr, "Not support group.");
> +        return -rte_errno;
> +    }
> +
> +    if (dh_flow) {
> +        dh_flow->group = attr->group;
> +        dh_flow->direct = (attr->ingress == 1) ? 0 : 1;
> +        dh_flow->pri = attr->priority;
> +    }
> +
> +    return 0;
> +}
> +
> +static int fd_flow_parse_pattern(struct rte_eth_dev *dev, const struct rte_flow_item *items,
> +             struct rte_flow_error *error, struct zxdh_flow *dh_flow)
> +{
> +    struct zxdh_hw *priv = dev->data->dev_private;
> +    struct zxdh_flow_info *flow = NULL;
> +    const struct rte_flow_item *item;
> +    const struct rte_flow_item_eth *eth_spec, *eth_mask;
> +    const struct rte_flow_item_vlan *vlan_spec, *vlan_mask;
> +    const struct rte_flow_item_ipv4 *ipv4_spec, *ipv4_mask;
> +    const struct rte_flow_item_ipv6 *ipv6_spec = NULL, *ipv6_mask = NULL;
> +    const struct rte_flow_item_tcp *tcp_spec, *tcp_mask;
> +    const struct rte_flow_item_udp *udp_spec, *udp_mask;
> +    const struct rte_flow_item_sctp *sctp_spec, *sctp_mask;
> +    const struct rte_flow_item_vxlan *vxlan_spec, *vxlan_mask;
> +    struct fd_flow_key *key, *key_mask;
> +
> +    if (dh_flow) {
> +        flow = &dh_flow->flowentry;
> +    } else {
> +        flow = rte_zmalloc("dh_flow", sizeof(*flow), 0);
> +        if (flow == NULL) {
> +            rte_flow_error_set(error, EINVAL,
> +                         RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                         "Failed to allocate memory ");
> +            return -rte_errno;
> +        }
> +    }
> +
> +    key = &flow->fd_flow.key;
> +    key_mask = &flow->fd_flow.key_mask;
> +    key->vfid = rte_cpu_to_be_16(priv->vfid);
> +    key_mask->vfid  = 0xffff;
> +    for (; items->type != RTE_FLOW_ITEM_TYPE_END; items++) {
> +        item = items;
> +        if (items->last) {
> +            rte_flow_error_set(error, EINVAL,
> +                     RTE_FLOW_ERROR_TYPE_ITEM,
> +                     items,
> +                     "Not support range");
> +            return -rte_errno;
> +        }
> +
> +        switch (item->type) {
> +        case RTE_FLOW_ITEM_TYPE_ETH:
> +            eth_spec = item->spec;
> +            eth_mask = item->mask;
> +            if (eth_spec && eth_mask) {
> +                key->mac_dst = eth_spec->dst;
> +                key->mac_src  = eth_spec->src;
> +                key_mask->mac_dst  = eth_mask->dst;
> +                key_mask->mac_src  = eth_mask->src;
> +
> +                if (eth_mask->type == 0xffff) {
> +                    key->ether_type = eth_spec->type;
> +                    key_mask->ether_type = eth_mask->type;
> +                }
> +            }
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_VLAN:
> +            vlan_spec = item->spec;
> +            vlan_mask = item->mask;
> +            if (vlan_spec && vlan_mask) {
> +                key->vlan_tci  = vlan_spec->tci;
> +                key_mask->vlan_tci = vlan_mask->tci;
> +            }
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_IPV4:
> +            ipv4_spec = item->spec;
> +            ipv4_mask = item->mask;
> +
> +            if (ipv4_spec && ipv4_mask) {
> +                /* Check IPv4 mask and update input set */
> +                if (ipv4_mask->hdr.version_ihl ||
> +                    ipv4_mask->hdr.total_length ||
> +                    ipv4_mask->hdr.packet_id ||
> +                    ipv4_mask->hdr.hdr_checksum ||
> +                    ipv4_mask->hdr.time_to_live) {
> +                    rte_flow_error_set(error, EINVAL,
> +                             RTE_FLOW_ERROR_TYPE_ITEM,
> +                             item,
> +                             "Invalid IPv4 mask.");
> +                    return -rte_errno;
> +                }
> +                    /* Get the filter info */
> +                key->nw_proto =
> +                        ipv4_spec->hdr.next_proto_id;
> +                key->tos =
> +                        ipv4_spec->hdr.type_of_service;
> +                key_mask->nw_proto =
> +                        ipv4_mask->hdr.next_proto_id;
> +                key_mask->tos =
> +                        ipv4_mask->hdr.type_of_service;
> +                key->frag_flag = (ipv4_spec->hdr.fragment_offset != 0) ? 1 : 0;
> +                key_mask->frag_flag = (ipv4_mask->hdr.fragment_offset != 0) ? 1 : 0;
> +                rte_memcpy((uint32_t *)key->src_ip + 3,
> +                             &ipv4_spec->hdr.src_addr, 4);
> +                rte_memcpy((uint32_t *)key->dst_ip + 3,
> +                             &ipv4_spec->hdr.dst_addr, 4);
> +                rte_memcpy((uint32_t *)key_mask->src_ip + 3,
> +                             &ipv4_mask->hdr.src_addr, 4);
> +                rte_memcpy((uint32_t *)key_mask->dst_ip + 3,
> +                             &ipv4_mask->hdr.dst_addr, 4);
> +            }
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_IPV6:
> +            ipv6_spec = item->spec;
> +            ipv6_mask = item->mask;
> +
> +            if (ipv6_spec && ipv6_mask) {
> +                /* Check IPv6 mask and update input set */
> +                if (ipv6_mask->hdr.payload_len ||
> +                     ipv6_mask->hdr.hop_limits == UINT8_MAX) {
> +                    rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ITEM,
> +                        item,
> +                        "Invalid IPv6 mask");
> +                    return -rte_errno;
> +                }
> +                key->tc =
> +                    (uint8_t)((ipv6_spec->hdr.vtc_flow &
> +                                RTE_IPV6_HDR_TC_MASK) >>
> +                                RTE_IPV6_HDR_TC_SHIFT);
> +                key_mask->tc =
> +                    (uint8_t)((ipv6_mask->hdr.vtc_flow &
> +                                RTE_IPV6_HDR_TC_MASK) >>
> +                                RTE_IPV6_HDR_TC_SHIFT);
> +
> +                key->nw_proto = ipv6_spec->hdr.proto;
> +                key_mask->nw_proto = ipv6_mask->hdr.proto;
> +
> +                rte_memcpy(key->src_ip,
> +                             &ipv6_spec->hdr.src_addr, 16);
> +                rte_memcpy(key->dst_ip,
> +                             &ipv6_spec->hdr.dst_addr, 16);
> +                rte_memcpy(key_mask->src_ip,
> +                             &ipv6_mask->hdr.src_addr, 16);
> +                rte_memcpy(key_mask->dst_ip,
> +                             &ipv6_mask->hdr.dst_addr, 16);
> +            }
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_TCP:
> +            tcp_spec = item->spec;
> +            tcp_mask = item->mask;
> +
> +            if (tcp_spec && tcp_mask) {
> +                /* Check TCP mask and update input set */
> +                if (tcp_mask->hdr.sent_seq ||
> +                    tcp_mask->hdr.recv_ack ||
> +                    tcp_mask->hdr.data_off ||
> +                    tcp_mask->hdr.tcp_flags ||
> +                    tcp_mask->hdr.rx_win ||
> +                    tcp_mask->hdr.cksum ||
> +                    tcp_mask->hdr.tcp_urp ||
> +                    (tcp_mask->hdr.src_port &&
> +                    tcp_mask->hdr.src_port != UINT16_MAX) ||
> +                    (tcp_mask->hdr.dst_port &&
> +                    tcp_mask->hdr.dst_port != UINT16_MAX)) {
> +                    rte_flow_error_set(error, EINVAL,
> +                                 RTE_FLOW_ERROR_TYPE_ITEM,
> +                                 item,
> +                                 "Invalid TCP mask");
> +                    return -rte_errno;
> +                }
> +
> +                key->tp_src = tcp_spec->hdr.src_port;
> +                key_mask->tp_src = tcp_mask->hdr.src_port;
> +
> +                key->tp_dst = tcp_spec->hdr.dst_port;
> +                key_mask->tp_dst = tcp_mask->hdr.dst_port;
> +            }
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_UDP:
> +            udp_spec = item->spec;
> +            udp_mask = item->mask;
> +
> +            if (udp_spec && udp_mask) {
> +                /* Check UDP mask and update input set*/
> +                if (udp_mask->hdr.dgram_len ||
> +                    udp_mask->hdr.dgram_cksum ||
> +                    (udp_mask->hdr.src_port &&
> +                    udp_mask->hdr.src_port != UINT16_MAX) ||
> +                    (udp_mask->hdr.dst_port &&
> +                    udp_mask->hdr.dst_port != UINT16_MAX)) {
> +                    rte_flow_error_set(error, EINVAL,
> +                                     RTE_FLOW_ERROR_TYPE_ITEM,
> +                                     item,
> +                                     "Invalid UDP mask");
> +                    return -rte_errno;
> +                }
> +
> +                key->tp_src = udp_spec->hdr.src_port;
> +                key_mask->tp_src = udp_mask->hdr.src_port;
> +
> +                key->tp_dst = udp_spec->hdr.dst_port;
> +                key_mask->tp_dst = udp_mask->hdr.dst_port;
> +            }
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_SCTP:
> +            sctp_spec = item->spec;
> +            sctp_mask = item->mask;
> +
> +            if (!(sctp_spec && sctp_mask))
> +                break;
> +
> +            /* Check SCTP mask and update input set */
> +            if (sctp_mask->hdr.cksum) {
> +                rte_flow_error_set(error, EINVAL,
> +                           RTE_FLOW_ERROR_TYPE_ITEM,
> +                           item,
> +                           "Invalid sctp mask");
> +                return -rte_errno;
> +            }
> +
> +            /* Mask for SCTP src/dst ports not supported */
> +            if (sctp_mask->hdr.src_port &&
> +                sctp_mask->hdr.src_port != UINT16_MAX)
> +                return -rte_errno;
> +            if (sctp_mask->hdr.dst_port &&
> +                sctp_mask->hdr.dst_port != UINT16_MAX)
> +                return -rte_errno;
> +
> +            key->tp_src = sctp_spec->hdr.src_port;
> +            key_mask->tp_src = sctp_mask->hdr.src_port;
> +            key->tp_dst = sctp_spec->hdr.dst_port;
> +            key_mask->tp_dst = sctp_mask->hdr.dst_port;
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_VXLAN:
> +        {
> +            vxlan_spec = item->spec;
> +            vxlan_mask = item->mask;
> +            static const struct rte_flow_item_vxlan flow_item_vxlan_mask = {
> +                .vni = {0xff, 0xff, 0xff},
> +            };
> +            if (!(vxlan_spec && vxlan_mask))
> +                break;
> +            if (memcmp(vxlan_mask, &flow_item_vxlan_mask,
> +                sizeof(struct rte_flow_item_vxlan))) {
> +                rte_flow_error_set(error, EINVAL,
> +                                 RTE_FLOW_ERROR_TYPE_ITEM,
> +                                 item,
> +                                 "Invalid vxlan mask");
> +                    return -rte_errno;
> +            }
> +            rte_memcpy(key->vni, vxlan_spec->vni, 3);
> +            rte_memcpy(key_mask->vni, vxlan_mask->vni, 3);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_VOID:
> +            break;
> +        default:
> +                return rte_flow_error_set(error, ENOTSUP,
> +                            RTE_FLOW_ERROR_TYPE_ITEM,
> +                            NULL, "item not supported");
> +        }
> +    }
> +
> +    data_bitwise(key_mask, sizeof(*key_mask));
> +    return 0;
> +}
> +
> +static inline int
> +validate_action_rss(struct rte_eth_dev *dev,
> +             const struct rte_flow_action *action,
> +             struct rte_flow_error *error)
> +{
> +    const struct rte_flow_action_rss *rss = action->conf;
> +
> +    if (rss->func != RTE_ETH_HASH_FUNCTION_DEFAULT &&
> +        rss->func != RTE_ETH_HASH_FUNCTION_TOEPLITZ) {
> +        rte_flow_error_set(error, ENOTSUP,
> +                RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                &rss->func,
> +                "RSS hash function not supported");
> +        return -rte_errno;
> +        }
> +
> +    if (rss->level > 1) {
> +        rte_flow_error_set(error, ENOTSUP,
> +                RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                &rss->level,
> +                "tunnel RSS is not supported");
> +        return -rte_errno;
> +    }
> +
> +    /* allow RSS key_len 0 in case of NULL (default) RSS key. */
> +    if (rss->key_len == 0 && rss->key != NULL) {
> +        rte_flow_error_set(error, ENOTSUP,
> +                RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                &rss->key_len,
> +                "RSS hash key length 0");
> +        return -rte_errno;
> +    }
> +
> +    if (rss->key_len > 0 && rss->key_len < ZXDH_RSS_HASH_KEY_LEN) {
> +        rte_flow_error_set(error, ENOTSUP,
> +                RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                &rss->key_len,
> +                "RSS hash key too small, value is 40U");
> +        return -rte_errno;
> +    }
> +
> +    if (rss->key_len > ZXDH_RSS_HASH_KEY_LEN) {
> +        rte_flow_error_set(error, ENOTSUP,
> +                RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                &rss->key_len,
> +                "RSS hash key too large, value is 40U");
> +        return -rte_errno;
> +    }
> +
> +    if (!rss->queue_num) {
> +        rte_flow_error_set(error, EINVAL,
> +                RTE_FLOW_ERROR_TYPE_ACTION_CONF,
> +                &dev->data->nb_rx_queues, "No queues configured");
> +        return -rte_errno;
> +    }
> +
> +    return 0;
> +}
> +
> +static int
> +fd_flow_parse_vxlan_encap(struct rte_eth_dev *dev __rte_unused,
> +        const struct rte_flow_item *item,
> +        struct zxdh_flow *dh_flow)
> +{
> +    const struct rte_flow_item *items;
> +    const struct rte_flow_item_eth *item_eth;
> +    const struct rte_flow_item_vlan *item_vlan;
> +    const struct rte_flow_item_ipv4 *item_ipv4;
> +    const struct rte_flow_item_ipv6 *item_ipv6;
> +    const struct rte_flow_item_udp *item_udp;
> +    const struct rte_flow_item_vxlan *item_vxlan;
> +    uint32_t i = 0;
> +    rte_be32_t addr;
> +
> +    for (i = 0; i < ACTION_VXLAN_ENCAP_ITEMS_NUM; i++) {
> +        items = &item[i];
> +        switch (items->type) {
> +        case RTE_FLOW_ITEM_TYPE_ETH:
> +            item_eth = items->spec;
> +            rte_memcpy(&dh_flow->encap0.dst_mac1, item_eth->dst.addr_bytes, 2);
> +            rte_memcpy(&dh_flow->encap1.src_mac1, item_eth->src.addr_bytes, 2);
> +            rte_memcpy(&dh_flow->encap0.dst_mac2, &item_eth->dst.addr_bytes[2], 4);
> +            rte_memcpy(&dh_flow->encap1.src_mac2, &item_eth->src.addr_bytes[2], 4);
> +            dh_flow->encap0.dst_mac1 = rte_bswap16(dh_flow->encap0.dst_mac1);
> +            dh_flow->encap1.src_mac1 = rte_bswap16(dh_flow->encap1.src_mac1);
> +            dh_flow->encap0.dst_mac2 = rte_bswap32(dh_flow->encap0.dst_mac2);
> +            dh_flow->encap1.src_mac2 = rte_bswap32(dh_flow->encap1.src_mac2);
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_VLAN:
> +            item_vlan = items->spec;
> +            dh_flow->encap1.vlan_tci = item_vlan->hdr.vlan_tci;
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_IPV4:
> +            item_ipv4 = items->spec;
> +            dh_flow->encap0.ethtype = 0;
> +            dh_flow->encap0.tos = item_ipv4->hdr.type_of_service;
> +            dh_flow->encap0.ttl = item_ipv4->hdr.time_to_live;
> +            addr = rte_bswap32(item_ipv4->hdr.src_addr);
> +            rte_memcpy((uint32_t *)dh_flow->encap1.sip.ip_addr + 3, &addr, 4);
> +            addr = rte_bswap32(item_ipv4->hdr.dst_addr);
> +            rte_memcpy((uint32_t *)dh_flow->encap0.dip.ip_addr + 3, &addr, 4);
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_IPV6:
> +            item_ipv6 = items->spec;
> +            dh_flow->encap0.ethtype = 1;
> +            dh_flow->encap0.tos =
> +                    (item_ipv6->hdr.vtc_flow & RTE_IPV6_HDR_TC_MASK) >>
> +                        RTE_IPV6_HDR_TC_SHIFT;
> +            dh_flow->encap0.ttl = item_ipv6->hdr.hop_limits;
> +            rte_memcpy(dh_flow->encap1.sip.ip_addr, &item_ipv6->hdr.src_addr, 16);
> +            dh_flow->encap1.sip.ip_addr[0] =
> +                rte_bswap32(dh_flow->encap1.sip.ip_addr[0]);
> +            dh_flow->encap1.sip.ip_addr[1] =
> +                rte_bswap32(dh_flow->encap1.sip.ip_addr[1]);
> +            dh_flow->encap1.sip.ip_addr[2] =
> +                rte_bswap32(dh_flow->encap1.sip.ip_addr[2]);
> +            dh_flow->encap1.sip.ip_addr[3] =
> +                rte_bswap32(dh_flow->encap1.sip.ip_addr[3]);
> +            rte_memcpy(dh_flow->encap0.dip.ip_addr, &item_ipv6->hdr.dst_addr, 16);
> +            dh_flow->encap0.dip.ip_addr[0] =
> +                    rte_bswap32(dh_flow->encap0.dip.ip_addr[0]);
> +            dh_flow->encap0.dip.ip_addr[1] =
> +                    rte_bswap32(dh_flow->encap0.dip.ip_addr[1]);
> +            dh_flow->encap0.dip.ip_addr[2] =
> +                    rte_bswap32(dh_flow->encap0.dip.ip_addr[2]);
> +            dh_flow->encap0.dip.ip_addr[3] =
> +                    rte_bswap32(dh_flow->encap0.dip.ip_addr[3]);
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_UDP:
> +            item_udp = items->spec;
> +            dh_flow->encap0.tp_dst = item_udp->hdr.dst_port;
> +            dh_flow->encap0.tp_dst = rte_bswap16(dh_flow->encap0.tp_dst);
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_VXLAN:
> +            item_vxlan = items->spec;
> +            dh_flow->encap0.vni = item_vxlan->vni[0] * 65536 +
> +                    item_vxlan->vni[1] * 256 + item_vxlan->vni[2];
> +            break;
> +        case RTE_FLOW_ITEM_TYPE_VOID:
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +    dh_flow->encap0.hit_flag = 1;
> +    dh_flow->encap1.hit_flag = 1;
> +
> +    return 0;
> +}
> +
> +static int
> +fd_flow_parse_action(struct rte_eth_dev *dev, const struct rte_flow_action *actions,
> +             struct rte_flow_error *error, struct zxdh_flow *dh_flow)
> +{
> +    struct zxdh_flow_info *flow = NULL;
> +    struct fd_flow_result *result = NULL;
> +    const struct rte_flow_item *enc_item = NULL;
> +    uint8_t action_bitmap = 0;
> +    uint32_t dest_num = 0;
> +    uint32_t mark_num = 0;
> +    uint32_t counter_num = 0;
> +    int ret;
> +
> +    rte_errno = 0;
> +    if (dh_flow) {
> +        flow = &dh_flow->flowentry;
> +    } else {
> +        flow = rte_zmalloc("dh_flow", sizeof(*flow), 0);
> +        if (flow == NULL) {
> +            rte_flow_error_set(error, EINVAL,
> +                     RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                     "Failed to allocate memory ");
> +            return -rte_errno;
> +        }
> +    }
> +    result = &flow->fd_flow.result;
> +    action_bitmap = result->action_idx;
> +
> +    for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
> +        switch (actions->type) {
> +        case RTE_FLOW_ACTION_TYPE_RSS:
> +        {
> +            dest_num++;
> +            if (action_bitmap & (1 << FD_ACTION_RSS_BIT)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "rss action does no support.");
> +                goto free_flow;
> +            }
> +            ret = validate_action_rss(dev, actions, error);
> +            if (ret)
> +                goto free_flow;
> +            action_bitmap |= (1 << FD_ACTION_RSS_BIT);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_MARK:
> +        {
> +            mark_num++;
> +            if (action_bitmap & (1 << FD_ACTION_MARK_BIT)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "multi mark action no support.");
> +                goto free_flow;
> +            }
> +            const struct rte_flow_action_mark *act_mark = actions->conf;
> +            result->mark_fd_id = rte_cpu_to_le_32(act_mark->id);
> +            action_bitmap |= (1 << FD_ACTION_MARK_BIT);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_COUNT:
> +        {
> +            counter_num++;
> +            if (action_bitmap & (1 << FD_ACTION_COUNT_BIT)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "multi count action no support.");
> +                goto free_flow;
> +            }
> +            const struct rte_flow_action_count *act_count = actions->conf;
> +            if (act_count->id > MAX_FLOW_COUNT_NUM) {
> +                rte_flow_error_set(error, EINVAL,
> +                            RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                            "count action id no support.");
> +                goto free_flow;
> +            };
> +            result->countid = act_count->id;
> +            action_bitmap |= (1 << FD_ACTION_COUNT_BIT);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_QUEUE:
> +        {
> +            dest_num++;
> +            if (action_bitmap & (1 << FD_ACTION_QUEUE_BIT)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "multi queue action no support.");
> +                goto free_flow;
> +            }
> +            const struct rte_flow_action_queue *act_q;
> +            act_q = actions->conf;
> +            if (act_q->index >= dev->data->nb_rx_queues) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "Invalid queue ID");
> +                goto free_flow;
> +            }
> +            ret = zxdh_hw_qid_to_logic_qid(dev, act_q->index << 1);
> +            if (ret < 0) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "Invalid phy queue ID .");
> +                goto free_flow;
> +            }
> +            result->qid = rte_cpu_to_le_16(ret);
> +            action_bitmap |= (1 << FD_ACTION_QUEUE_BIT);
> +
> +            PMD_DRV_LOG(DEBUG, "QID RET 0x%x", result->qid);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_DROP:
> +        {
> +            dest_num++;
> +            if (action_bitmap & (1 << FD_ACTION_DROP_BIT)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "multi drop action no support.");
> +                goto free_flow;
> +            }
> +            action_bitmap |= (1 << FD_ACTION_DROP_BIT);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_VXLAN_DECAP:
> +        {
> +            dest_num++;
> +            if (action_bitmap & (1 << FD_ACTION_VXLAN_DECAP)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "multi drop action no support.");
> +                goto free_flow;
> +            }
> +            action_bitmap |= (1 << FD_ACTION_VXLAN_DECAP);
> +            break;
> +        }
> +        case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP:
> +            enc_item = ((const struct rte_flow_action_vxlan_encap *)
> +                   actions->conf)->definition;
> +            if (dh_flow != NULL)
> +                fd_flow_parse_vxlan_encap(dev, enc_item, dh_flow);
> +            dest_num++;
> +            if (action_bitmap & (1 << FD_ACTION_VXLAN_ENCAP)) {
> +                rte_flow_error_set(error, EINVAL,
> +                        RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                        "multi drop action no support.");
> +                goto free_flow;
> +            }
> +            action_bitmap |= (1 << FD_ACTION_VXLAN_ENCAP);
> +            break;
> +        default:
> +            rte_flow_error_set(error, EINVAL,
> +                RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +                "Invalid action.");
> +            goto free_flow;
> +        }
> +    }
> +
> +    if (dest_num >= 2) {
> +        rte_flow_error_set(error, EINVAL,
> +               RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +               "Unsupported action combination");
> +        return -rte_errno;
> +    }
> +
> +    if (mark_num >= 2) {
> +        rte_flow_error_set(error, EINVAL,
> +               RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +               "Too many mark actions");
> +        return -rte_errno;
> +    }
> +
> +    if (counter_num >= 2) {
> +        rte_flow_error_set(error, EINVAL,
> +               RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +               "Too many count actions");
> +        return -rte_errno;
> +    }
> +
> +    if (dest_num + mark_num + counter_num == 0) {
> +        rte_flow_error_set(error, EINVAL,
> +               RTE_FLOW_ERROR_TYPE_ACTION, actions,
> +               "Empty action, packet forwarding as default");
> +        return -rte_errno;
> +    }
> +
> +    result->action_idx = action_bitmap;
> +    return 0;
> +
> +free_flow:
> +    if (!dh_flow)
> +        rte_free(flow);
> +    return -rte_errno;
> +}
> +
> +static int
> +fd_parse_pattern_action(struct rte_eth_dev *dev,
> +            const struct rte_flow_attr *attr,
> +            const struct rte_flow_item pattern[],
> +            const struct rte_flow_action *actions,
> +            struct rte_flow_error *error, struct zxdh_flow *dh_flow)
> +{
> +    int ret = 0;
> +    ret = fd_flow_parse_attr(dev, attr, error, dh_flow);
> +    if (ret < 0)
> +        return -rte_errno;
> +    ret = fd_flow_parse_pattern(dev, pattern, error, dh_flow);
> +    if (ret < 0)
> +        return -rte_errno;
> +
> +    ret = fd_flow_parse_action(dev, actions, error, dh_flow);
> +    if (ret < 0)
> +        return -rte_errno;
> +    return 0;
> +}
> +
> +struct dh_flow_engine pf_fd_engine = {
> +    .apply = pf_fd_hw_apply,
> +    .destroy = pf_fd_hw_destroy,
> +    .query_count = pf_fd_hw_query_count,
> +    .parse_pattern_action = fd_parse_pattern_action,
> +    .type = FLOW_TYPE_FD_TCAM,
> +};
> +
> +
> +static int
> +vf_flow_msg_process(enum zxdh_msg_type msg_type, struct rte_eth_dev *dev,
> +        struct zxdh_flow *dh_flow, struct rte_flow_error *error,
> +        struct rte_flow_query_count *count)
> +{
> +    int ret = 0;
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    struct zxdh_msg_info msg_info = {0};
> +    struct zxdh_flow_op_msg *flow_msg = &msg_info.data.flow_msg;
> +
> +    uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +    void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +    void *flow_rsp_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body_addr, flow_rsp);
> +    uint8_t flow_op_rsp[sizeof(struct zxdh_flow_op_rsp)] = {0};
> +    uint16_t len = sizeof(struct zxdh_flow_op_rsp) - 4;
> +    struct zxdh_flow_op_rsp *flow_rsp = (struct zxdh_flow_op_rsp *)flow_op_rsp;
> +
> +    dh_flow->hash_search_index = hw->hash_search_index;
> +    rte_memcpy(&flow_msg->dh_flow, dh_flow, sizeof(struct zxdh_flow));
> +
> +    zxdh_msg_head_build(hw, msg_type, &msg_info);
> +    ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(struct zxdh_msg_info),
> +            (void *)zxdh_msg_reply_info, ZXDH_ST_SZ_BYTES(msg_reply_info));
> +    zxdh_adjust_flow_op_rsp_memory_layout(flow_rsp_addr, len, flow_op_rsp);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "port %d flow op %d failed ret %d", hw->port_id, msg_type, ret);
> +        if (ret == -2) {
> +            PMD_DRV_LOG(ERR, "port %d  flow %d failed: cause %s",
> +                 hw->port_id, msg_type, flow_rsp->error.reason);
> +            rte_flow_error_set(error, EBUSY,
> +                     RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +                     flow_rsp->error.reason);
> +        } else {
> +            rte_flow_error_set(error, EBUSY,
> +                     RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +                     "msg channel error");
> +        }
> +        return ret;
> +    }
> +
> +    if (msg_type == ZXDH_FLOW_HW_ADD)
> +        dh_flow->flowentry.hw_idx = flow_rsp->dh_flow.flowentry.hw_idx;
> +    if (count)
> +        rte_memcpy((void *)count, &flow_rsp->count, sizeof(flow_rsp->count));
> +
> +    return ret;
> +}
> +
> +static int
> +vf_fd_apply(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +        struct rte_flow_error *error, uint16_t vport __rte_unused,
> +        uint16_t pcieid __rte_unused)
> +{
> +    int ret = 0;
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    ret =  vf_flow_msg_process(ZXDH_FLOW_HW_ADD, dev, dh_flow, error, NULL);
> +    if (!ret) {
> +        uint8_t action_bits = dh_flow->flowentry.fd_flow.result.action_idx;
> +        if (((action_bits & (1 << FD_ACTION_VXLAN_ENCAP)) != 0) ||
> +                ((action_bits & (1 << FD_ACTION_VXLAN_DECAP)) != 0)) {
> +            hw->vxlan_fd_num++;
> +            if (hw->vxlan_fd_num == 1) {
> +                set_vxlan_enable(dev, 1, error);
> +                PMD_DRV_LOG(DEBUG, "vf set_vxlan_enable");
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
> +static int
> +vf_fd_destroy(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +        struct rte_flow_error *error, uint16_t vport __rte_unused,
> +        uint16_t pcieid __rte_unused)
> +{
> +    int ret = 0;
> +    struct zxdh_hw *hw = dev->data->dev_private;
> +    ret = vf_flow_msg_process(ZXDH_FLOW_HW_DEL, dev, dh_flow, error, NULL);
> +    if (!ret) {
> +        uint8_t action_bits = dh_flow->flowentry.fd_flow.result.action_idx;
> +        if (((action_bits & (1 << FD_ACTION_VXLAN_ENCAP)) != 0) ||
> +                ((action_bits & (1 << FD_ACTION_VXLAN_DECAP)) != 0)) {
> +            hw->vxlan_fd_num--;
> +            if (hw->vxlan_fd_num == 0) {
> +                set_vxlan_enable(dev, 0, error);
> +                PMD_DRV_LOG(DEBUG, "vf set_vxlan_disable");
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +
> +static int
> +vf_fd_query_count(struct rte_eth_dev *dev,
> +        struct zxdh_flow *dh_flow,
> +        struct rte_flow_query_count *count,
> +        struct rte_flow_error *error)
> +{
> +    int ret = 0;
> +    ret = vf_flow_msg_process(ZXDH_FLOW_HW_GET, dev, dh_flow, error, count);
> +    return ret;
> +}
> +
> +
> +static struct dh_flow_engine vf_fd_engine = {
> +    .apply = vf_fd_apply,
> +    .destroy = vf_fd_destroy,
> +    .parse_pattern_action = fd_parse_pattern_action,
> +    .query_count = vf_fd_query_count,
> +    .type = FLOW_TYPE_FD_TCAM,
> +};
> +
> +void zxdh_flow_init(struct rte_eth_dev *dev)
> +{
> +    struct zxdh_hw *priv =  dev->data->dev_private;
> +    if (priv->is_pf)
> +        zxdh_register_flow_engine(&pf_fd_engine);
> +    else
> +        zxdh_register_flow_engine(&vf_fd_engine);
> +    TAILQ_INIT(&priv->dh_flow_list);
> +}
> +
> +const struct rte_flow_ops zxdh_flow_ops = {
> +    .validate = zxdh_flow_validate,
> +    .create = zxdh_flow_create,
> +    .destroy = zxdh_flow_destroy,
> +    .flush = zxdh_flow_flush,
> +    .query = zxdh_flow_query,
> +    .dev_dump = zxdh_flow_dev_dump,
> +};
> +
> +int
> +zxdh_flow_ops_get(struct rte_eth_dev *dev __rte_unused,
> +        const struct rte_flow_ops **ops)
> +{
> +    *ops = &zxdh_flow_ops;
> +
> +    return 0;
> +}
> +
> +void
> +zxdh_flow_release(struct rte_eth_dev *dev)
> +{
> +    struct rte_flow_error error = {0};
> +    const struct rte_flow_ops *flow_ops = NULL;
> +
> +    if (dev->dev_ops && dev->dev_ops->flow_ops_get)
> +        dev->dev_ops->flow_ops_get(dev, &flow_ops);
> +    if (flow_ops && flow_ops->flush)
> +        flow_ops->flush(dev, &error);
> +}
> diff --git a/drivers/net/zxdh/zxdh_flow.h b/drivers/net/zxdh/zxdh_flow.h
> new file mode 100644
> index 0000000000..adbc6b2a15
> --- /dev/null
> +++ b/drivers/net/zxdh/zxdh_flow.h
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 ZTE Corporation
> + */
> +
> +#ifndef ZXDH_FLOW_H
> +#define ZXDH_FLOW_H
> +
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <sys/queue.h>
> +
> +#include <rte_arp.h>
> +#include <rte_common.h>
> +#include <rte_ether.h>
> +#include <rte_icmp.h>
> +#include <rte_ip.h>
> +#include <rte_sctp.h>
> +#include <rte_tcp.h>
> +#include <rte_udp.h>
> +#include <rte_byteorder.h>
> +#include <rte_flow_driver.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#define MAX_GROUP                  1
> +#define ZXDH_MAX_FLOW_NUM          2048
> +#define MAX_FLOW_COUNT_NUM         ZXDH_MAX_FLOW_NUM
> +#define ZXDH_FLOW_GROUP_TCAM       1
> +
> +#ifndef IPv4_BYTES
> +#define IPv4_BYTES_FMT "%" PRIu8 ".%" PRIu8 ".%" PRIu8 ".%" PRIu8
> +#define IPv4_BYTES(addr) \
> +        (uint8_t)(((addr) >> 24) & 0xFF),\
> +        (uint8_t)(((addr) >> 16) & 0xFF),\
> +        (uint8_t)(((addr) >> 8) & 0xFF),\
> +        (uint8_t)((addr) & 0xFF)
> +#endif
> +
> +#ifndef IPv6_BYTES
> +#define IPv6_BYTES_FMT "%02x%02x:%02x%02x:%02x%02x:%02x%02x:" \
> +                        "%02x%02x:%02x%02x:%02x%02x:%02x%02x"
> +#define IPv6_BYTES(addr) \
> +    addr[0], addr[1], addr[2], addr[3], addr[4], addr[5], addr[6], addr[7], \
> +    addr[8], addr[9], addr[10], addr[11], addr[12], addr[13], addr[14], addr[15]
> +#endif
> +
> +enum {
> +    FD_ACTION_VXLAN_ENCAP = 0,
> +    FD_ACTION_VXLAN_DECAP = 1,
> +    FD_ACTION_RSS_BIT = 2,
> +    FD_ACTION_COUNT_BIT = 3,
> +    FD_ACTION_DROP_BIT = 4,
> +    FD_ACTION_MARK_BIT = 5,
> +    FD_ACTION_QUEUE_BIT = 6,
> +};
> +
> +/**
> + * HW table, little-endian as default
> + **/
> +struct fd_flow_key {
> +    struct rte_ether_addr mac_dst; /**< Destination MAC. */
> +    struct rte_ether_addr mac_src; /**< Source MAC. */
> +    rte_be16_t ether_type; /**< EtherType  */
> +    union {
> +        struct {
> +            rte_be16_t cvlan_pri:4; /**< vlanid 0xfff is valid */
> +            rte_be16_t cvlan_vlanid:12; /**< vlanid 0xfff is valid */
> +        };
> +        rte_be16_t  vlan_tci;
> +    };
> +
> +    uint8_t  src_ip[16];  /** ip src  */
> +    uint8_t  dst_ip[16];  /** ip dst  */
> +    uint8_t  rsv0;
> +    union {
> +        uint8_t  tos;
> +        uint8_t  tc;
> +    };
> +    uint8_t  nw_proto;
> +    uint8_t  frag_flag;/*1表示分片 0 表示非分片*/
> +    rte_be16_t  tp_src;
> +    rte_be16_t  tp_dst;
> +
> +    uint8_t rsv1;/**/
> +    uint8_t vni[3];/**/
> +
> +    rte_be16_t vfid;
> +    uint8_t rsv2[18];
> +};
> +
> +struct fd_flow_result {
> +    rte_le16_t qid;
> +    uint8_t rsv0;
> +
> +    uint8_t action_idx:7;
> +    uint8_t hit_flag:1;
> +
> +    rte_le32_t mark_fd_id;
> +    rte_le32_t countid:20;
> +    rte_le32_t encap1_index:12;
> +
> +    rte_le16_t encap0_index:12;
> +    rte_le16_t rsv1:4;
> +    uint8_t rss_hash_factor;
> +    uint8_t rss_hash_alg;
> +};
> +
> +struct fd_flow_entry {
> +    struct fd_flow_key key;
> +    struct fd_flow_key key_mask;
> +    struct fd_flow_result result;
> +};
> +
> +struct flow_stats {
> +    uint32_t hit_pkts_hi;
> +    uint32_t hit_pkts_lo;
> +    uint32_t hit_bytes_hi;
> +    uint32_t hit_bytes_lo;
> +};
> +
> +
> +enum dh_flow_type {
> +     FLOW_TYPE_FLOW = 0,
> +     FLOW_TYPE_FD_TCAM,
> +     FLOW_TYPE_FD_SW,
> +};
> +
> +struct zxdh_flow_info {
> +    enum dh_flow_type flowtype;
> +    uint16_t hw_idx;
> +    uint16_t rsv;
> +    union {
> +        struct fd_flow_entry fd_flow;
> +    };
> +};
> +
> +struct tunnel_encap_ip {
> +    rte_be32_t ip_addr[4];
> +};
> +
> +struct tunnel_encap0 {
> +    uint8_t tos;
> +    uint8_t rsv2[2];
> +    uint8_t rsv1: 6;
> +    uint8_t ethtype: 1;
> +    uint8_t hit_flag: 1;
> +    uint16_t dst_mac1;
> +    uint16_t tp_dst;
> +    uint32_t dst_mac2;
> +    uint32_t ttl:8;
> +    uint32_t vni:24;
> +    struct tunnel_encap_ip dip;
> +};
> +
> +struct tunnel_encap1 {
> +    uint32_t rsv1: 31;
> +    uint32_t hit_flag: 1;
> +    uint16_t src_mac1;
> +    uint16_t vlan_tci;
> +    uint32_t src_mac2;
> +    uint32_t rsv;
> +    struct tunnel_encap_ip sip;
> +};
> +
> +struct zxdh_flow {
> +    uint8_t direct; /* 0 in 1 out */
> +    uint8_t group;  /* rule group id */
> +    uint8_t pri; /* priority */
> +    uint8_t hash_search_index; /*  */
> +    struct zxdh_flow_info  flowentry;
> +    struct tunnel_encap0  encap0;
> +    struct tunnel_encap1  encap1;
> +};
> +TAILQ_HEAD(dh_flow_list, rte_flow);
> +
> +struct rte_flow {
> +    TAILQ_ENTRY(rte_flow) next;
> +    void *driver_flow;
> +    uint32_t type;
> +    uint16_t port_id;
> +};
> +
> +struct count_res {
> +    rte_spinlock_t count_lock;
> +    uint8_t count_ref;
> +    uint8_t rev[3];
> +};
> +
> +/* Struct to store engine created. */
> +struct dh_flow_engine {
> +    TAILQ_ENTRY(dh_flow_engine) node;
> +    enum dh_flow_type type;
> +    int (*apply)
> +        (struct rte_eth_dev *dev,
> +         struct zxdh_flow *dh_flow,
> +         struct rte_flow_error *error,
> +         uint16_t vport, uint16_t pcieid);
> +
> +    int (*parse_pattern_action)
> +        (struct rte_eth_dev *dev,
> +         const struct rte_flow_attr *attr,
> +         const struct rte_flow_item pattern[],
> +         const struct rte_flow_action *actions,
> +         struct rte_flow_error *error,
> +         struct zxdh_flow *dh_flow);
> +
> +    int (*destroy)
> +        (struct rte_eth_dev *dev,
> +         struct zxdh_flow *dh_flow,
> +         struct rte_flow_error *error,
> +         uint16_t vport, uint16_t pcieid);
> +
> +    int (*query_count)
> +        (struct rte_eth_dev *dev,
> +         struct zxdh_flow *dh_flow,
> +         struct rte_flow_query_count *count,
> +         struct rte_flow_error *error);
> +};
> +TAILQ_HEAD(dh_engine_list, dh_flow_engine);
> +
> +void zxdh_register_flow_engine(struct dh_flow_engine *engine);
> +
> +extern const struct rte_flow_ops zxdh_flow_ops;
> +
> +void zxdh_flow_global_init(void);
> +void zxdh_flow_init(struct rte_eth_dev *dev);
> +int pf_fd_hw_apply(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +                 struct rte_flow_error *error, uint16_t vport, uint16_t pcieid);
> +int pf_fd_hw_destroy(struct rte_eth_dev *dev, struct zxdh_flow *dh_flow,
> +                 struct rte_flow_error *error, uint16_t vport, uint16_t pcieid);
> +int pf_fd_hw_query_count(struct rte_eth_dev *dev,
> +                        struct zxdh_flow *flow,
> +                        struct rte_flow_query_count *count,
> +                        struct rte_flow_error *error);
> +int zxdh_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops);
> +void zxdh_flow_release(struct rte_eth_dev *dev);
> +
> +#endif /* ZXDH_FLOW_H */
> diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
> index 980509500f..196e27f91c 100644
> --- a/drivers/net/zxdh/zxdh_msg.c
> +++ b/drivers/net/zxdh/zxdh_msg.c
> @@ -19,6 +19,7 @@
>  #include "zxdh_tables.h"
>  #include "zxdh_np.h"
>  #include "zxdh_common.h"
> +#include "zxdh_flow.h"
>  
>  #define ZXDH_REPS_INFO_FLAG_USABLE  0x00
>  #define ZXDH_BAR_SEQID_NUM_MAX      256
> @@ -1296,7 +1297,8 @@ zxdh_vf_vlan_table_init(struct zxdh_hw *hw, uint16_t vport)
>  }
>  
>  static int
> -zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data,
>          void *res_info, uint16_t *res_len)
>  {
>      struct zxdh_port_attr_table port_attr = {0};
> @@ -1314,7 +1316,8 @@ zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>      port_attr.pf_vfid = pf_hw->vfid;
>      port_attr.hash_search_index = pf_hw->hash_search_index;
>      port_attr.port_base_qid = vf_init_msg->base_qid;
> -
> +    int vf_index = VF_IDX(pcieid);
> +    pf_hw->vfinfo[vf_index].vport = vport;
>      ret = zxdh_set_port_attr(pf_hw, vport, &port_attr);
>      if (ret) {
>          PMD_DRV_LOG(ERR, "set vport attr failed, code:%d", ret);
> @@ -1333,6 +1336,11 @@ zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>          goto proc_end;
>      }
>  
> +    ret = zxdh_np_dtb_acl_offline_delete(pf_hw->dev_id, pf_hw->dev_sd->dtb_sd.queueid,
> +                ZXDH_SDT_FD_TABLE, vport, ZXDH_FLOW_STATS_INGRESS_BASE, 1);
> +    if (ret)
> +        PMD_DRV_LOG(ERR, "flow table delete failed. code:%d", ret);
> +
>      ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
>      *res_len = sizeof(uint8_t);
>  
> @@ -1344,30 +1352,30 @@ zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_mac_clear(struct zxdh_hw *hw, union zxdh_virport_num vport)
> +zxdh_mac_clear(struct zxdh_hw *hw, union zxdh_virport_num vport, uint16_t pcieid)
>  {
> -    uint16_t vf_id = vport.vfid;
> +    uint16_t vf_index = VF_IDX(pcieid);
>      int i;
>      int ret = 0;
>  
>      for (i = 0; (i != ZXDH_MAX_MAC_ADDRS); ++i) {
> -        if (!rte_is_zero_ether_addr(&hw->vfinfo[vf_id].vf_mac[i])) {
> +        if (!rte_is_zero_ether_addr(&hw->vfinfo[vf_index].vf_mac[i])) {
>              ret = zxdh_del_mac_table(hw, vport.vport,
> -                    &hw->vfinfo[vf_id].vf_mac[i],
> +                    &hw->vfinfo[vf_index].vf_mac[i],
>                      hw->hash_search_index, 0, 0);
>              if (ret) {
>                  PMD_DRV_LOG(ERR, "vf_del_mac_failed. code:%d", ret);
>                  return ret;
>              }
> -            memset(&hw->vfinfo[vf_id].vf_mac[i], 0, sizeof(struct rte_ether_addr));
> +            memset(&hw->vfinfo[vf_index].vf_mac[i], 0, sizeof(struct rte_ether_addr));
>          }
>      }
>      return ret;
>  }
>  
>  static int
> -zxdh_vf_port_uninit(struct zxdh_hw *pf_hw,
> -        uint16_t vport, void *cfg_data __rte_unused,
> +zxdh_vf_port_uninit(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data __rte_unused,
>          void *res_info, uint16_t *res_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "uninit";
> @@ -1385,7 +1393,7 @@ zxdh_vf_port_uninit(struct zxdh_hw *pf_hw,
>          goto proc_end;
>      }
>  
> -    ret = zxdh_mac_clear(pf_hw, vport_num);
> +    ret = zxdh_mac_clear(pf_hw, vport_num, pcieid);
>      if (ret) {
>          PMD_DRV_LOG(ERR, "zxdh_mac_clear failed, code:%d", ret);
>          goto proc_end;
> @@ -1410,7 +1418,8 @@ zxdh_vf_port_uninit(struct zxdh_hw *pf_hw,
>  }
>  
>  static int
> -zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data,
>          void *reply_body, uint16_t *reply_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "add mac";
> @@ -1419,12 +1428,12 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>      struct rte_ether_addr *addr = &mac_filter->mac;
>      void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body, reply_data);
>      void *mac_reply_msg_addr = ZXDH_ADDR_OF(msg_reply_body, reply_body, mac_reply_msg);
> +    uint16_t vf_index = VF_IDX(pcieid);
>      port.vport = vport;
> -    uint16_t vf_id = port.vfid;
>      int i = 0, ret = 0;
>  
>      for (i = 0; i < ZXDH_MAX_MAC_ADDRS; i++)
> -        if (rte_is_same_ether_addr(&hw->vfinfo[vf_id].vf_mac[i], addr))
> +        if (rte_is_same_ether_addr(&hw->vfinfo[vf_index].vf_mac[i], addr))
>              goto success;
>  
>      ret = zxdh_add_mac_table(hw, vport, addr, hw->hash_search_index, 0, 0);
> @@ -1440,8 +1449,8 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>          goto failure;
>      }
>      for (i = 0; i < ZXDH_MAX_MAC_ADDRS; i++) {
> -        if (rte_is_zero_ether_addr(&hw->vfinfo[vf_id].vf_mac[i])) {
> -            memcpy(&hw->vfinfo[vf_id].vf_mac[i], addr, 6);
> +        if (rte_is_zero_ether_addr(&hw->vfinfo[vf_index].vf_mac[i])) {
> +            memcpy(&hw->vfinfo[vf_index].vf_mac[i], addr, 6);
>              break;
>          }
>      }
> @@ -1461,14 +1470,15 @@ zxdh_add_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -    void *res_info, uint16_t *res_len)
> +zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      struct zxdh_mac_filter *mac_filter = (struct zxdh_mac_filter *)cfg_data;
>      union zxdh_virport_num  port = (union zxdh_virport_num)vport;
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "del mac";
>      void *reply_data_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, reply_data);
> -    uint16_t vf_id = port.vfid;
> +    uint16_t vf_index = VF_IDX(pcieid);
>      int ret, i = 0;
>  
>      PMD_DRV_LOG(DEBUG, "[PF GET MSG FROM VF]--vf mac to del.");
> @@ -1483,8 +1493,8 @@ zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>      }
>  
>      for (i = 0; i < ZXDH_MAX_MAC_ADDRS; i++) {
> -        if (rte_is_same_ether_addr(&hw->vfinfo[vf_id].vf_mac[i], &mac_filter->mac))
> -            memset(&hw->vfinfo[vf_id].vf_mac[i], 0, sizeof(struct rte_ether_addr));
> +        if (rte_is_same_ether_addr(&hw->vfinfo[vf_index].vf_mac[i], &mac_filter->mac))
> +            memset(&hw->vfinfo[vf_index].vf_mac[i], 0, sizeof(struct rte_ether_addr));
>      }
>  
>      sprintf(str, "vport 0x%x del mac ret 0x%x\n", port.vport, ret);
> @@ -1500,7 +1510,8 @@ zxdh_del_vf_mac_table(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_promisc_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_promisc_set(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
>          void *reply, uint16_t *res_len)
>  {
>      struct zxdh_port_promisc_msg *promisc_msg = (struct zxdh_port_promisc_msg *)cfg_data;
> @@ -1531,7 +1542,8 @@ zxdh_vf_promisc_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_vlan_filter_table_process(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_vlan_filter_table_process(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
>          void *res_info, uint16_t *res_len, uint8_t enable)
>  {
>      struct zxdh_vlan_filter *vlan_filter = cfg_data;
> @@ -1556,21 +1568,24 @@ zxdh_vf_vlan_filter_table_process(struct zxdh_hw *hw, uint16_t vport, void *cfg_
>  }
>  
>  static int
> -zxdh_vf_vlan_filter_table_add(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_vlan_filter_table_add(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data,
>          void *res_info, uint16_t *res_len)
>  {
> -    return zxdh_vf_vlan_filter_table_process(hw, vport, cfg_data, res_info, res_len, 1);
> +    return zxdh_vf_vlan_filter_table_process(hw, vport, pcieid, cfg_data, res_info, res_len, 1);
>  }
>  
>  static int
> -zxdh_vf_vlan_filter_table_del(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_vlan_filter_table_del(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data,
>          void *res_info, uint16_t *res_len)
>  {
> -    return zxdh_vf_vlan_filter_table_process(hw, vport, cfg_data, res_info, res_len, 0);
> +    return zxdh_vf_vlan_filter_table_process(hw, vport, pcieid, cfg_data, res_info, res_len, 0);
>  }
>  
>  static int
> -zxdh_vf_set_vlan_filter(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_set_vlan_filter(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
>          void *reply, uint16_t *res_len)
>  {
>      struct zxdh_vlan_filter_set *vlan_filter = cfg_data;
> @@ -1594,7 +1609,8 @@ zxdh_vf_set_vlan_filter(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_set_vlan_offload(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_set_vlan_offload(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
>          void *reply, uint16_t *res_len)
>  {
>      struct zxdh_vlan_offload *vlan_offload = cfg_data;
> @@ -1621,8 +1637,9 @@ zxdh_vf_set_vlan_offload(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_rss_hf_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_unused,
> -            void *reply, uint16_t *res_len)
> +zxdh_vf_rss_hf_get(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data __rte_unused,
> +        void *reply, uint16_t *res_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_hf";
>      struct zxdh_port_attr_table vport_att = {0};
> @@ -1650,8 +1667,9 @@ zxdh_vf_rss_hf_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_unus
>  }
>  
>  static int
> -zxdh_vf_rss_hf_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -            void *reply, uint16_t *res_len)
> +zxdh_vf_rss_hf_set(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *reply, uint16_t *res_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_hf";
>      struct zxdh_rss_hf *rss_hf = cfg_data;
> @@ -1686,8 +1704,9 @@ zxdh_vf_rss_hf_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_rss_enable(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -            void *reply, uint16_t *res_len)
> +zxdh_vf_rss_enable(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *reply, uint16_t *res_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_enable";
>      struct zxdh_rss_enable *rss_enable = cfg_data;
> @@ -1722,7 +1741,8 @@ zxdh_vf_rss_enable(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_rss_table_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_rss_table_set(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
>          void *reply, uint16_t *res_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_table";
> @@ -1744,7 +1764,8 @@ zxdh_vf_rss_table_set(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
>  }
>  
>  static int
> -zxdh_vf_rss_table_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_unused,
> +zxdh_vf_rss_table_get(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data __rte_unused,
>          void *reply, uint16_t *res_len)
>  {
>      char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "rss_table";
> @@ -1770,8 +1791,9 @@ zxdh_vf_rss_table_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_u
>  }
>  
>  static int
> -zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
> -    void *res_info, uint16_t *res_len)
> +zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      RTE_ASSERT(!cfg_data || !pf_hw);
>      if (res_info)
> @@ -1833,8 +1855,8 @@ zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>  
>  static int
>  zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
> -        void *cfg_data, void *res_info,
> -        uint16_t *res_len)
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      struct zxdh_np_stats_updata_msg *np_stats_query =
>               (struct zxdh_np_stats_updata_msg  *)cfg_data;
> @@ -2015,10 +2037,9 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
>  }
>  
>  static int
> -zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw,
> -    uint16_t vport, void *cfg_data,
> -    void *res_info,
> -    uint16_t *res_len)
> +zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      struct zxdh_mtr_stats_query  *zxdh_mtr_stats_query =
>              (struct zxdh_mtr_stats_query  *)cfg_data;
> @@ -2048,11 +2069,9 @@ zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw,
>  }
>  
>  static int
> -zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw,
> -    uint16_t vport,
> -    void *cfg_data,
> -    void *res_info,
> -    uint16_t *res_len)
> +zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      if (!cfg_data || !res_len || !res_info) {
>          PMD_DRV_LOG(ERR, " get profileid invalid inparams");
> @@ -2088,11 +2107,9 @@ zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw,
>  }
>  
>  static int
> -zxdh_vf_mtr_hw_profile_del(struct zxdh_hw *pf_hw,
> -    uint16_t vport,
> -    void *cfg_data,
> -    void *res_info,
> -    uint16_t *res_len)
> +zxdh_vf_mtr_hw_profile_del(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      if (!cfg_data || !res_len || !res_info) {
>          PMD_DRV_LOG(ERR, " del profileid  invalid inparams");
> @@ -2130,11 +2147,9 @@ zxdh_vf_mtr_hw_profile_del(struct zxdh_hw *pf_hw,
>  }
>  
>  static int
> -zxdh_vf_mtr_hw_plcrflow_cfg(struct zxdh_hw *pf_hw,
> -    uint16_t vport,
> -    void *cfg_data,
> -    void *res_info,
> -    uint16_t *res_len)
> +zxdh_vf_mtr_hw_plcrflow_cfg(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      int ret = 0;
>  
> @@ -2169,11 +2184,9 @@ zxdh_vf_mtr_hw_plcrflow_cfg(struct zxdh_hw *pf_hw,
>  }
>  
>  static int
> -zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw __rte_unused,
> -    uint16_t vport,
> -    void *cfg_data,
> -    void *res_info,
> -    uint16_t *res_len)
> +zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
>  {
>      int ret = 0;
>  
> @@ -2203,7 +2216,8 @@ zxdh_vf_mtr_hw_profile_cfg(struct zxdh_hw *pf_hw __rte_unused,
>  }
>  
>  static int
> -zxdh_vf_vlan_tpid_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
> +zxdh_vf_vlan_tpid_set(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
>          void *res_info, uint16_t *res_len)
>  {
>      struct zxdh_vlan_tpid *vlan_tpid = (struct zxdh_vlan_tpid *)cfg_data;
> @@ -2231,6 +2245,120 @@ zxdh_vf_vlan_tpid_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
>      return ret;
>  }
>  
> +static int
> +zxdh_vf_flow_hw_add(struct zxdh_hw *pf_hw, uint16_t vport,
> +         uint16_t pcieid, void *cfg_data,
> +         void *res_info, uint16_t *res_len)
> +{
> +    if (!cfg_data || !res_len || !res_info) {
> +        PMD_DRV_LOG(ERR, "invalid inparams");
> +        return -1;
> +    }
> +    struct rte_flow_error error = {0};
> +    int ret = 0;
> +    struct zxdh_flow_op_msg  *flow_entry = (struct zxdh_flow_op_msg *)cfg_data;
> +    struct zxdh_flow  *dh_flow;
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
> +    *res_len = sizeof(struct zxdh_flow_op_rsp) - 4;
> +
> +    ret = pf_fd_hw_apply(pf_hw->eth_dev, &flow_entry->dh_flow, &error, vport, pcieid);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "pf 0x%x for vf 0x%x flow add failed ret :%d",
> +            pf_hw->vport.vport, vport, ret);
> +        return -1;
> +    }
> +    void *flow_rsp_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, flow_rsp);
> +    dh_flow = flow_rsp_addr;
> +    dh_flow->flowentry.hw_idx = flow_entry->dh_flow.flowentry.hw_idx;
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
> +    return 0;
> +}
> +
> +static int
> +zxdh_vf_flow_hw_del(struct zxdh_hw *pf_hw, uint16_t vport,
> +            uint16_t pcieid, void *cfg_data,
> +            void *res_info, uint16_t *res_len)
> +{
> +    if (!cfg_data || !res_len || !res_info) {
> +        PMD_DRV_LOG(ERR, "invalid inparams");
> +        return -1;
> +    }
> +    struct rte_flow_error error = {0};
> +    int ret = 0;
> +    struct zxdh_flow_op_msg  *flow_entry = (struct zxdh_flow_op_msg *)cfg_data;
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
> +    *res_len = sizeof(struct zxdh_flow_op_rsp) - 4;
> +
> +    ret = pf_fd_hw_destroy(pf_hw->eth_dev, &flow_entry->dh_flow, &error, vport, pcieid);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "pf 0x%x for vf 0x%x flow del failed ret :%d",
> +            pf_hw->vport.vport, vport, ret);
> +        return -1;
> +    }
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
> +    return 0;
> +}
> +
> +static int
> +zxdh_vf_flow_hw_get(struct zxdh_hw *pf_hw, uint16_t vport,
> +        uint16_t pcieid __rte_unused, void *cfg_data,
> +        void *res_info, uint16_t *res_len)
> +{
> +    if (!cfg_data || !res_len || !res_info) {
> +        PMD_DRV_LOG(ERR, "invalid inparams");
> +        return -1;
> +    }
> +
> +    void *flow_rsp_addr = ZXDH_ADDR_OF(msg_reply_body, res_info, flow_rsp);
> +    void *count_addr = (uint8_t *)flow_rsp_addr + sizeof(struct zxdh_flow);
> +    struct rte_flow_error error = {0};
> +    int ret = 0;
> +    struct zxdh_flow_op_msg  *flow_entry = (struct zxdh_flow_op_msg *)cfg_data;
> +    struct zxdh_flow  *dh_flow;
> +
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
> +    *res_len = sizeof(struct zxdh_flow_op_rsp) - 4;
> +
> +    PMD_DRV_LOG(INFO, "handle %d", flow_entry->dh_flow.flowentry.hw_idx);
> +    ret = pf_fd_hw_query_count(pf_hw->eth_dev, &flow_entry->dh_flow, count_addr, &error);
> +    if (ret) {
> +        PMD_DRV_LOG(DEBUG, "pf 0x%x for vf 0x%x flow get failed ret :%d",
> +            pf_hw->vport.vport, vport, ret);
> +        return -1;
> +    }
> +    PMD_DRV_LOG(INFO, " res len :%d", *res_len);
> +    dh_flow = flow_rsp_addr;
> +    rte_memcpy(&dh_flow->flowentry, &flow_entry->dh_flow.flowentry, sizeof(dh_flow->flowentry));
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
> +    return 0;
> +}
> +
> +static int
> +zxdh_vf_flow_hw_flush(struct zxdh_hw *pf_hw, uint16_t vport,
> +            uint16_t pcieid __rte_unused, void *cfg_data,
> +            void *res_info, uint16_t *res_len)
> +{
> +    if (!cfg_data || !res_len || !res_info) {
> +        PMD_DRV_LOG(ERR, "invalid inparams");
> +        return -1;
> +    }
> +    int ret = 0;
> +    uint16_t queue_id = pf_hw->dev_sd->dtb_sd.queueid;
> +
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_FAIL);
> +    *res_len = sizeof(struct zxdh_flow_op_rsp) - 4;
> +
> +    ret = zxdh_np_dtb_acl_offline_delete(pf_hw->dev_id, queue_id, ZXDH_SDT_FD_TABLE,
> +                vport, ZXDH_FLOW_STATS_INGRESS_BASE, 1);
> +    if (ret) {
> +        PMD_DRV_LOG(ERR, "flow flush failed. code:%d", ret);
> +        return -1;
> +    }
> +
> +    ZXDH_SET(msg_reply_body, res_info, flag, ZXDH_REPS_SUCC);
> +    return 0;
> +}
> +
>  static const zxdh_msg_process_callback zxdh_proc_cb[] = {
>      [ZXDH_NULL] = NULL,
>      [ZXDH_VF_PORT_INIT] = zxdh_vf_port_init,
> @@ -2255,6 +2383,10 @@ static const zxdh_msg_process_callback zxdh_proc_cb[] = {
>      [ZXDH_PLCR_CAR_PROFILE_ID_DELETE] =  zxdh_vf_mtr_hw_profile_del,
>      [ZXDH_PLCR_CAR_QUEUE_CFG_SET] = zxdh_vf_mtr_hw_plcrflow_cfg,
>      [ZXDH_PLCR_CAR_PROFILE_CFG_SET] = zxdh_vf_mtr_hw_profile_cfg,
> +    [ZXDH_FLOW_HW_ADD] = zxdh_vf_flow_hw_add,
> +    [ZXDH_FLOW_HW_DEL] = zxdh_vf_flow_hw_del,
> +    [ZXDH_FLOW_HW_GET] = zxdh_vf_flow_hw_get,
> +    [ZXDH_FLOW_HW_FLUSH] = zxdh_vf_flow_hw_flush,
>  };
>  
>  static inline int
> @@ -2269,7 +2401,7 @@ zxdh_config_process_callback(struct zxdh_hw *hw, struct zxdh_msg_info *msg_info,
>          return -1;
>      }
>      if (zxdh_proc_cb[msghead->msg_type]) {
> -        ret = zxdh_proc_cb[msghead->msg_type](hw, msghead->vport,
> +        ret = zxdh_proc_cb[msghead->msg_type](hw, msghead->vport, msghead->pcieid,
>                      (void *)&msg_info->data, res, res_len);
>          if (!ret)
>              ZXDH_SET(msg_reply_body, res, flag, ZXDH_REPS_SUCC);
> diff --git a/drivers/net/zxdh/zxdh_msg.h b/drivers/net/zxdh/zxdh_msg.h
> index 579d938a0d..61a3da878e 100644
> --- a/drivers/net/zxdh/zxdh_msg.h
> +++ b/drivers/net/zxdh/zxdh_msg.h
> @@ -241,6 +241,11 @@ enum zxdh_msg_type {
>      ZXDH_PLCR_CAR_QUEUE_CFG_SET = 40,
>      ZXDH_PORT_METER_STAT_GET = 42,
>  
> +    ZXDH_FLOW_HW_ADD = 46,
> +    ZXDH_FLOW_HW_DEL = 47,
> +    ZXDH_FLOW_HW_GET = 48,
> +    ZXDH_FLOW_HW_FLUSH = 49,
> +
>      ZXDH_MSG_TYPE_END,
>  };
>  
> @@ -419,6 +424,21 @@ struct zxdh_ifc_mtr_profile_info_bits {
>      uint8_t profile_id[0x40];
>  };
>  
> +struct err_reason {
> +    uint8_t err_type;
> +    uint8_t rsv[3];
> +    char reason[512];
> +};
> +
> +struct zxdh_flow_op_rsp {
> +    struct zxdh_flow  dh_flow;
> +    uint8_t rev[4];
> +    union {
> +        struct rte_flow_query_count count;
> +        struct err_reason error;
> +    };
> +};
> +
>  struct zxdh_ifc_msg_reply_body_bits {
>      uint8_t flag[0x8];
>      union {
> @@ -433,6 +453,7 @@ struct zxdh_ifc_msg_reply_body_bits {
>          struct zxdh_ifc_agent_mac_module_eeprom_msg_bits module_eeprom_msg;
>          struct zxdh_ifc_mtr_profile_info_bits  mtr_profile_info;
>          struct zxdh_ifc_mtr_stats_bits hw_mtr_stats;
> +        struct zxdh_flow_op_rsp  flow_rsp;
>      };
>  };
>  
> @@ -540,6 +561,10 @@ struct zxdh_vlan_tpid {
>      uint16_t tpid;
>  };
>  
> +struct zxdh_flow_op_msg {
> +    struct zxdh_flow dh_flow;
> +};
> +
>  struct zxdh_msg_info {
>      union {
>          uint8_t head_len[ZXDH_MSG_HEAD_LEN];
> @@ -567,6 +592,7 @@ struct zxdh_msg_info {
>          struct zxdh_plcr_profile_cfg zxdh_plcr_profile_cfg;
>          struct zxdh_plcr_flow_cfg  zxdh_plcr_flow_cfg;
>          struct zxdh_mtr_stats_query  zxdh_mtr_stats_query;
> +        struct zxdh_flow_op_msg flow_msg;
>      } data;
>  };
>  
> @@ -594,8 +620,9 @@ struct zxdh_inic_recv_msg {
>  
>  typedef int (*zxdh_bar_chan_msg_recv_callback)(void *pay_load, uint16_t len,
>          void *reps_buffer, uint16_t *reps_len, void *dev);
> -typedef int (*zxdh_msg_process_callback)(struct zxdh_hw *hw, uint16_t vport, void *cfg_data,
> -    void *res_info, uint16_t *res_len);
> +typedef int (*zxdh_msg_process_callback)(struct zxdh_hw *hw, uint16_t vport,
> +        uint16_t pcieid, void *cfg_data,
> +        void *res_info, uint16_t *res_len);
>  
>  typedef int (*zxdh_bar_chan_msg_recv_callback)(void *pay_load, uint16_t len,
>              void *reps_buffer, uint16_t *reps_len, void *dev);
> diff --git a/drivers/net/zxdh/zxdh_tables.h b/drivers/net/zxdh/zxdh_tables.h
> index 3280ff1f89..8cfc833333 100644
> --- a/drivers/net/zxdh/zxdh_tables.h
> +++ b/drivers/net/zxdh/zxdh_tables.h
> @@ -7,6 +7,8 @@
>  
>  #include <stdint.h>
>  
> +#include <zxdh_msg.h>
> +
>  /* eram */
>  #define ZXDH_SDT_VPORT_ATT_TABLE          1
>  #define ZXDH_SDT_PANEL_ATT_TABLE          2
> @@ -16,6 +18,8 @@
>  #define ZXDH_SDT_UNICAST_ATT_TABLE        10
>  #define ZXDH_SDT_MULTICAST_ATT_TABLE      11
>  #define ZXDH_SDT_PORT_VLAN_ATT_TABLE      16
> +#define ZXDH_SDT_TUNNEL_ENCAP0_TABLE      28
> +#define ZXDH_SDT_TUNNEL_ENCAP1_TABLE      29
>  /* hash */
>  #define ZXDH_SDT_L2_ENTRY_TABLE0          64
>  #define ZXDH_SDT_L2_ENTRY_TABLE1          65
> @@ -27,12 +31,14 @@
>  #define ZXDH_SDT_MC_TABLE2                78
>  #define ZXDH_SDT_MC_TABLE3                79
>  
> +#define ZXDH_SDT_FD_TABLE                 130
> +
>  #define ZXDH_PORT_VHCA_FLAG                       1
>  #define ZXDH_PORT_RSS_HASH_FACTOR_FLAG            3
>  #define ZXDH_PORT_HASH_ALG_FLAG                   4
>  #define ZXDH_PORT_PHY_PORT_FLAG                   5
>  #define ZXDH_PORT_LAG_ID_FLAG                     6
> -
> +#define ZXDH_PORT_VXLAN_OFFLOAD_EN_OFF            7
>  #define ZXDH_PORT_PF_VQM_VFID_FLAG                8
>  
>  #define ZXDH_PORT_MTU_FLAG                        10
> @@ -169,7 +175,7 @@ struct zxdh_port_attr_table {
>      uint8_t phy_port: 4;
>  
>      uint16_t lag_id : 3;
> -    uint16_t rsv81 : 1;
> +    uint16_t fd_vxlan_offload_en : 1;
>      uint16_t pf_vfid : 11;
>      uint16_t rsv82 : 1;
>  
> -- 
> 2.27.0
> 
>
--8323328-1721063060-1755244860=:9147--
