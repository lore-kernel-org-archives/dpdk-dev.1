Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4104C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 23:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9005140261;
	Tue, 11 Mar 2025 00:19:18 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id C9EDF400D7
 for <dev@dpdk.org>; Tue, 11 Mar 2025 00:19:17 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so7425204a91.0
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741648757;
 x=1742253557; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNq9Pv93u73JT0dyVso3cTktV02lIdoVXHQwdHM9J+Q=;
 b=1vhSMwTtdvRBTFunlQAK9QQxBj1p+v6WDNkSkzzt28HWZtwIeKSOj1KSHf+9ploFgq
 T2h0mj99U/KHfMBmMj0Knzr/iklESZrr2zjOSB38xuwstCcS77fH2X0BcLwhZogX/kOo
 VvxOCZTighz44gJa3lDbHQrS0kWvnpvyYqJ/v+5ESKpbyJ/UZkP/BNxmvn1gt26Od2tH
 wC1kftc2FBPV0oRXAxAKgR24USdclOFYWPwd17OeY73jW5Djgpy79mSUV0ZBMcH3kKYJ
 79m2uTJxbuJpE5dBkrMa6iO+cNKAqxz0scImzY8s9AQ988MarbJJ5+TgMzKj7GtuGSTN
 cDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741648757; x=1742253557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNq9Pv93u73JT0dyVso3cTktV02lIdoVXHQwdHM9J+Q=;
 b=lJI9g3bYL2an2ZLS6KLPxL+WhJJJZ/OYeOSaoBBJhHzXuYF47dJx+Sju8FQf7S5d6R
 BUtj0NvkcIo+R3UEJzwlqqqV3cYWqlBBkd8TOCmS8LcRVfCP8imkcKtGzsDbUPHxlfg/
 Dt8ImaZZrlqjLOX8qGaosmDJFpqLZPh7Mse5OUf+rq9hp9RYYAoYKzhOQF127a3jJbw5
 BKKYkNvHcP8qn1d8xptBcTeZHkdIn/uU7qkiTVOLePsCTaW8of/SLbYy5r8ukzHCZBWL
 6DTklspapjtFjJJxolNuM7sji3CGqzm0683NSoSCSTqeQAjvFi2eskFZc5BflYPOr9ZU
 O0Iw==
X-Gm-Message-State: AOJu0YxA+A9BMoc/2SilkgLHgam+48vvZypwUU0nJYSXByOknzuoxHUW
 7wmeoKWzZTb7CbBvPyjRC3+zbxkO4G/fynJvIBjSifUU5+0q34gRMHjP4Rm+SGU=
X-Gm-Gg: ASbGncu/JMv9y1Xe+r+HMuwStsfI/l/iev0COe5by5qJuEqcR2aMIJhWr0IvC0rKjy1
 1uutNmShEy8SoIsbUKWnAkq5rlvmVrU1AtfV/1/QLOnbZPeGxLsG7nQ6YX2oULlMOi3uFCBf7M9
 SOzzj2fQ0KRkEyxZKQGslgDzXF5FceBQXMQM3MJPWO8PFVVNdlDE4YNa6Gra3KefUnQjF4uyK7v
 3LxYsjuv0SyH0HAKoDYy3eAMNslh294GGysOWsIeXP2kWCkZwKKu1Q/uzjU2/9fjOimSzK71L83
 +x6gSKCOishrdB3HRq+vHqN0pxXLgCxsQXoz1rf5b2oOxs36AmICQEm4kZ6dQHbzxl2acETJsok
 DNp2SinfpyqlRQzxghtvdnw==
X-Google-Smtp-Source: AGHT+IH3jg1IyFTizYad3b7OhJzYMgtTbQXSN1JZjsX61ZpJAswEVvvbgxQsV990Vsh16aMVuek3uw==
X-Received: by 2002:a17:90b:3b48:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2ff7ce7b5f5mr22809316a91.4.1741648756676; 
 Mon, 10 Mar 2025 16:19:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddc7esm84400015ad.48.2025.03.10.16.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 16:19:16 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:19:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 01/14] net/zxdh: add network processor registers ops
Message-ID: <20250310161913.5c0bf1c9@hermes.local>
In-Reply-To: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:44:41 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Add (np)network processor registers read/write interfaces.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>

When sending followup patches, please use the convention of using a new
version number and a reply-to so that it stays in same thread in mail.

This appears to be v2 of a previous patchset.

> ---
>  drivers/net/zxdh/zxdh_np.c | 792 +++++++++++++++++++++++++++++++------
>  drivers/net/zxdh/zxdh_np.h |  94 ++++-
>  2 files changed, 761 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
> index 1e6e8f0e75..cbab2a3aaa 100644
> --- a/drivers/net/zxdh/zxdh_np.c
> +++ b/drivers/net/zxdh/zxdh_np.c
> @@ -14,7 +14,6 @@
>  #include "zxdh_np.h"
>  #include "zxdh_logs.h"
>  
> -static uint64_t g_np_bar_offset;
>  static ZXDH_DEV_MGR_T g_dev_mgr;
>  static ZXDH_SDT_MGR_T g_sdt_mgr;
>  static uint32_t g_dpp_dtb_int_enable;
> @@ -22,14 +21,185 @@ static uint32_t g_table_type[ZXDH_DEV_CHANNEL_MAX][ZXDH_DEV_SDT_ID_MAX];
>  ZXDH_PPU_CLS_BITMAP_T g_ppu_cls_bit_map[ZXDH_DEV_CHANNEL_MAX];
>  ZXDH_DTB_MGR_T *p_dpp_dtb_mgr[ZXDH_DEV_CHANNEL_MAX];
>  ZXDH_RISCV_DTB_MGR *p_riscv_dtb_queue_mgr[ZXDH_DEV_CHANNEL_MAX];
> -ZXDH_TLB_MGR_T *g_p_dpp_tlb_mgr[ZXDH_DEV_CHANNEL_MAX];
> -ZXDH_REG_T g_dpp_reg_info[4];
> -ZXDH_DTB_TABLE_T g_dpp_dtb_table_info[4];
>  ZXDH_SDT_TBL_DATA_T g_sdt_info[ZXDH_DEV_CHANNEL_MAX][ZXDH_DEV_SDT_ID_MAX];
>  ZXDH_PPU_STAT_CFG_T g_ppu_stat_cfg;

New tables appear to be immutable and should be marked as const. 
This will allow compiler to catch bugs where table value gets changed.

>  
> +ZXDH_FIELD_T g_smmu0_smmu0_cpu_ind_cmd_reg[] = {
> +	{"cpu_ind_rw", ZXDH_FIELD_FLAG_RW, 31, 1, 0x0, 0x0},
> +	{"cpu_ind_rd_mode", ZXDH_FIELD_FLAG_RW, 30, 1, 0x0, 0x0},
> +	{"cpu_req_mode", ZXDH_FIELD_FLAG_RW, 27, 2, 0x0, 0x0},
> +	{"cpu_ind_addr", ZXDH_FIELD_FLAG_RW, 25, 26, 0x0, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_smmu0_smmu0_cpu_ind_rd_done_reg[] = {
> +	{"cpu_ind_rd_done", ZXDH_FIELD_FLAG_RO, 0, 1, 0x0, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_smmu0_smmu0_cpu_ind_rdat0_reg[] = {
> +	{"cpu_ind_rdat0", ZXDH_FIELD_FLAG_RO, 31, 32, 0x0, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_smmu0_smmu0_cpu_ind_rdat1_reg[] = {
> +	{"cpu_ind_rdat1", ZXDH_FIELD_FLAG_RO, 31, 32, 0x0, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_smmu0_smmu0_cpu_ind_rdat2_reg[] = {
> +	{"cpu_ind_rdat2", ZXDH_FIELD_FLAG_RO, 31, 32, 0x0, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_smmu0_smmu0_cpu_ind_rdat3_reg[] = {
> +	{"cpu_ind_rdat3", ZXDH_FIELD_FLAG_RO, 31, 32, 0x0, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_smmu0_smmu0_wr_arb_cpu_rdy_reg[] = {
> +	{"wr_arb_cpu_rdy", ZXDH_FIELD_FLAG_RO, 0, 1, 0x1, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_dtb4k_dtb_enq_info_queue_buf_space_left_0_127_reg[] = {
> +	{"info_queue_buf_space_left", ZXDH_FIELD_FLAG_RO, 5, 6, 0x20, 0x0},
> +};
> +
> +ZXDH_FIELD_T g_dtb4k_dtb_enq_cfg_epid_v_func_num_0_127_reg[] = {
> +	{"dbi_en", ZXDH_FIELD_FLAG_RW, 31, 1, 0x0, 0x0},
> +	{"queue_en", ZXDH_FIELD_FLAG_RW, 30, 1, 0x0, 0x0},
> +	{"cfg_epid", ZXDH_FIELD_FLAG_RW, 27, 4, 0x0, 0x0},
> +	{"cfg_vfunc_num", ZXDH_FIELD_FLAG_RW, 23, 8, 0x0, 0x0},
> +	{"cfg_vector", ZXDH_FIELD_FLAG_RW, 14, 7, 0x0, 0x0},
> +	{"cfg_func_num", ZXDH_FIELD_FLAG_RW, 7, 3, 0x0, 0x0},
> +	{"cfg_vfunc_active", ZXDH_FIELD_FLAG_RW, 0, 1, 0x0, 0x0},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_ddr_table_cmd_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"rw_len", 123, 2},
> +	{"v46_flag", 121, 1},
> +	{"lpm_wr_vld", 120, 1},
> +	{"baddr", 119, 20},
> +	{"ecc_en", 99, 1},
> +	{"rw_addr", 29, 30},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_eram_table_cmd_1_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"data_mode", 123, 2},
> +	{"cpu_wr", 121, 1},
> +	{"cpu_rd", 120, 1},
> +	{"cpu_rd_mode", 119, 1},
> +	{"addr", 113, 26},
> +	{"data_h", 0, 1},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_eram_table_cmd_64_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"data_mode", 123, 2},
> +	{"cpu_wr", 121, 1},
> +	{"cpu_rd", 120, 1},
> +	{"cpu_rd_mode", 119, 1},
> +	{"addr", 113, 26},
> +	{"data_h", 63, 32},
> +	{"data_l", 31, 32},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_eram_table_cmd_128_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"data_mode", 123, 2},
> +	{"cpu_wr", 121, 1},
> +	{"cpu_rd", 120, 1},
> +	{"cpu_rd_mode", 119, 1},
> +	{"addr", 113, 26},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_zcam_table_cmd_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"ram_reg_flag", 123, 1},
> +	{"zgroup_id", 122, 2},
> +	{"zblock_id", 120, 3},
> +	{"zcell_id", 117, 2},
> +	{"mask", 115, 4},
> +	{"sram_addr", 111, 9},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_etcam_table_cmd_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"block_sel", 123, 3},
> +	{"init_en", 120, 1},
> +	{"row_or_col_msk", 119, 1},
> +	{"vben", 118, 1},
> +	{"reg_tcam_flag", 117, 1},
> +	{"uload", 116, 8},
> +	{"rd_wr", 108, 1},
> +	{"wr_mode", 107, 8},
> +	{"data_or_mask", 99, 1},
> +	{"addr", 98, 9},
> +	{"vbit", 89, 8},
> +};
> +
> +ZXDH_DTB_FIELD_T g_dtb_mc_hash_table_cmd_info[] = {
> +	{"valid", 127, 1},
> +	{"type_mode", 126, 3},
> +	{"std_h", 63, 32},
> +	{"std_l", 31, 32},
> +};
> +
> +ZXDH_DTB_TABLE_T g_dpp_dtb_table_info[] = {
> +	{
> +		"ddr",
> +		ZXDH_DTB_TABLE_DDR,
> +		8,
> +		g_dtb_ddr_table_cmd_info,
> +	},
> +	{
> +		"eram 1 bit",
> +		ZXDH_DTB_TABLE_ERAM_1,
> +		8,
> +		g_dtb_eram_table_cmd_1_info,
> +	},
> +	{
> +		"eram 64 bit",
> +		ZXDH_DTB_TABLE_ERAM_64,
> +		9,
> +		g_dtb_eram_table_cmd_64_info,
> +	},
> +	{
> +		"eram 128 bit",
> +		ZXDH_DTB_TABLE_ERAM_128,
> +		7,
> +		g_dtb_eram_table_cmd_128_info,
> +	},
> +	{
> +		"zcam",
> +		ZXDH_DTB_TABLE_ZCAM,
> +		8,
> +		g_dtb_zcam_table_cmd_info,
> +	},
> +	{
> +		"etcam",
> +		ZXDH_DTB_TABLE_ETCAM,
> +		13,
> +		g_dtb_etcam_table_cmd_info,
> +	},
> +	{
> +		"mc_hash",
> +		ZXDH_DTB_TABLE_MC_HASH,
> +		4,
> +		g_dtb_mc_hash_table_cmd_info
> +	},
> +};

All those tables can be const.


>  #define ZXDH_SDT_MGR_PTR_GET()    (&g_sdt_mgr)
>  #define ZXDH_SDT_SOFT_TBL_GET(id) (g_sdt_mgr.sdt_tbl_array[id])
> +#define ZXDH_DEV_INFO_GET(id) (g_dev_mgr.p_dev_array[id])
> +
> +#define ZXDH_DTB_LEN(cmd_type, int_en, data_len) \
> +	(((data_len) & 0x3ff) | \
> +	((int_en) << 29) | \
> +	((cmd_type) << 30))
>  
>  #define ZXDH_COMM_MASK_BIT(_bitnum_)\
>  	(0x1U << (_bitnum_))
> @@ -115,8 +285,23 @@ do {\
>  	} \
>  } while (0)
>  
> +static inline uint16_t zxdh_np_comm_convert16(uint16_t w_data)
> +{
> +	return ((w_data) & 0xff) << 8 | ((w_data) & 0xff00) >> 8;
> +}
> +
> +static inline uint32_t
> +zxdh_np_comm_convert32(uint32_t dw_data)
> +{
> +	return ((dw_data) & 0xff) << 24 | ((dw_data) & 0xff00) << 8 |
> +		((dw_data) & 0xff0000) >> 8 | ((dw_data) & 0xff000000) >> 24;
> +}
> +
>  #define ZXDH_COMM_CONVERT16(w_data) \
> -			(((w_data) & 0xff) << 8)
> +			zxdh_np_comm_convert16(w_data)
> +
> +#define ZXDH_COMM_CONVERT32(w_data) \
> +			zxdh_np_comm_convert32(w_data)
>  
>  #define ZXDH_DTB_TAB_UP_WR_INDEX_GET(DEV_ID, QUEUE_ID)       \
>  		(p_dpp_dtb_mgr[(DEV_ID)]->queue_info[(QUEUE_ID)].tab_up.wr_index)
> @@ -174,7 +359,7 @@ zxdh_np_comm_swap(uint8_t *p_uc_data, uint32_t dw_byte_len)
>  	uc_byte_mode = dw_byte_len % 4 & 0xff;
>  
>  	for (i = 0; i < dw_byte_num; i++) {
> -		(*p_dw_tmp) = ZXDH_COMM_CONVERT16(*p_dw_tmp);
> +		(*p_dw_tmp) = ZXDH_COMM_CONVERT32(*p_dw_tmp);
>  		p_dw_tmp++;
>  	}
>  
> @@ -198,6 +383,329 @@ zxdh_np_dev_init(void)
>  	return 0;
>  }
>  
> +static uint32_t
> +zxdh_np_dev_read_channel(uint32_t dev_id, uint32_t addr, uint32_t size, uint32_t *p_data)
> +{
> +	ZXDH_DEV_CFG_T *p_dev_info = NULL;
> +
> +	p_dev_info = ZXDH_DEV_INFO_GET(dev_id);
> +
> +	if (p_dev_info == NULL) {
> +		PMD_DRV_LOG(ERR, "Error: Channel[%d] dev is not exist",
> +			dev_id);
> +		return ZXDH_ERR;
> +	}
> +	if (p_dev_info->access_type == ZXDH_DEV_ACCESS_TYPE_PCIE) {
> +		p_dev_info->p_pcie_read_fun(dev_id, addr, size, p_data);
> +	} else {
> +		PMD_DRV_LOG(ERR, "Dev access type[ %d ] is invalid",
> +			p_dev_info->access_type);

Use %u not %d here.

> +		return ZXDH_ERR;
> +	}
> +
> +	return ZXDH_OK;
> +}
> +
> +static uint32_t
> +zxdh_np_dev_write_channel(uint32_t dev_id, uint32_t addr, uint32_t size, uint32_t *p_data)
> +{
> +	ZXDH_DEV_CFG_T *p_dev_info = NULL;
> +
> +	p_dev_info = ZXDH_DEV_INFO_GET(dev_id);
> +
> +	if (p_dev_info == NULL) {
> +		PMD_DRV_LOG(ERR, "Error: Channel[%d] dev is not exist",
> +			dev_id);
> +		return ZXDH_ERR;
> +	}
> +	if (p_dev_info->access_type == ZXDH_DEV_ACCESS_TYPE_PCIE) {
> +		p_dev_info->p_pcie_write_fun(dev_id, addr, size, p_data);
> +	} else {
> +		PMD_DRV_LOG(ERR, "Dev access type[ %d ] is invalid",
> +			p_dev_info->access_type);
> +		return ZXDH_ERR;
> +	}
> +
> +	return ZXDH_OK;
> +}
> +
> +static void
> +zxdh_np_pci_write32(uint64_t abs_addr, uint32_t *p_data)
> +{
> +	uint32_t data = 0;
> +	uint64_t addr = 0;
> +
> +	data = *p_data;
> +
> +	if (zxdh_np_comm_is_big_endian())
> +		data = ZXDH_COMM_CONVERT32(data);
> +
> +	addr = abs_addr + ZXDH_SYS_VF_NP_BASE_OFFSET;
> +	*((volatile uint32_t *)addr) = data;
> +}
> +
> +static void
> +zxdh_np_pci_read32(uint64_t abs_addr, uint32_t *p_data)
> +{
> +	uint32_t data = 0;
> +	uint64_t addr = 0;
> +
> +	addr = abs_addr + ZXDH_SYS_VF_NP_BASE_OFFSET;
> +	data = *((volatile uint32_t *)addr);
> +
> +	if (zxdh_np_comm_is_big_endian())
> +		data = ZXDH_COMM_CONVERT32(data);
> +
> +	*p_data = data;
> +}
> +
> +static uint64_t
> +zxdh_np_dev_get_pcie_addr(uint32_t dev_id)
> +{
> +	ZXDH_DEV_MGR_T *p_dev_mgr = NULL;
> +	ZXDH_DEV_CFG_T *p_dev_info = NULL;
> +
> +	p_dev_mgr = &g_dev_mgr;
> +	p_dev_info = p_dev_mgr->p_dev_array[dev_id];
> +
> +	if (p_dev_info == NULL)
> +		return ZXDH_DEV_TYPE_INVALID;
> +
> +	return p_dev_info->pcie_addr;
> +}
> +
> +static void
> +zxdh_np_dev_pcie_default_write(uint32_t dev_id, uint32_t addr, uint32_t size, uint32_t *p_data)
> +{
> +	uint32_t i;
> +	uint64_t abs_addr = 0;
> +
> +	abs_addr = zxdh_np_dev_get_pcie_addr(dev_id) + addr;
> +
> +	for (i = 0; i < size; i++)
> +		zxdh_np_pci_write32(abs_addr + 4 * i, p_data + i);
> +}
> +
> +static void
> +zxdh_np_dev_pcie_default_read(uint32_t dev_id, uint32_t addr, uint32_t size, uint32_t *p_data)
> +{
> +	uint32_t i;
> +	uint64_t abs_addr = 0;
> +
> +	abs_addr = zxdh_np_dev_get_pcie_addr(dev_id) + addr;
> +
> +	for (i = 0; i < size; i++)
> +		zxdh_np_pci_read32(abs_addr + 4 * i, p_data + i);
> +}
> +
> +static uint32_t
> +zxdh_np_read(uint32_t dev_id, uint32_t addr, uint32_t *p_data)
> +{
> +	return zxdh_np_dev_read_channel(dev_id, addr, 1, p_data);
> +}
> +
> +static uint32_t
> +zxdh_np_write(uint32_t dev_id, uint32_t addr, uint32_t *p_data)
> +{
> +	return zxdh_np_dev_write_channel(dev_id, addr, 1, p_data);
> +}
> +
> +static uint32_t
> +zxdh_np_se_smmu0_write(uint32_t dev_id, uint32_t addr, uint32_t *p_data)
> +{
> +	return zxdh_np_write(dev_id, addr, p_data);
> +}
> +
> +static uint32_t
> +zxdh_np_se_smmu0_read(uint32_t dev_id, uint32_t addr, uint32_t *p_data)
> +{
> +	return zxdh_np_read(dev_id, addr, p_data);
> +}
> +
> +ZXDH_REG_T g_dpp_reg_info[] = {
> +	{
> +		"cpu_ind_cmd",
> +		669,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x00000014,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		4,
> +		g_smmu0_smmu0_cpu_ind_cmd_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},

Please use named initializers for complex structures.
There was a case in another driver where one element in list like this
was skipped leading to a bug.

> +	{
> +		"cpu_ind_rd_done",
> +		670,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x00000040,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		1,
> +		g_smmu0_smmu0_cpu_ind_rd_done_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},
> +	{
> +		"cpu_ind_rdat0",
> +		671,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x00000044,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		1,
> +		g_smmu0_smmu0_cpu_ind_rdat0_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},
> +	{
> +		"cpu_ind_rdat1",
> +		672,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x00000048,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		1,
> +		g_smmu0_smmu0_cpu_ind_rdat1_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},
> +	{
> +		"cpu_ind_rdat2",
> +		673,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x0000004c,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		1,
> +		g_smmu0_smmu0_cpu_ind_rdat2_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},
> +	{
> +		"cpu_ind_rdat3",
> +		674,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x00000050,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		1,
> +		g_smmu0_smmu0_cpu_ind_rdat3_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},
> +	{
> +		"wr_arb_cpu_rdy",
> +		676,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x0000010c,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		1,
> +		g_smmu0_smmu0_wr_arb_cpu_rdy_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},
> +		{
> +		"info_queue_buf_space_left_0_127",
> +		820,
> +		DTB4K,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_UNI_ARRAY,
> +		ZXDH_SYS_DTB_BASE_ADDR + ZXDH_MODULE_DTB_ENQ_BASE_ADDR + 0x000c,
> +		(32 / 8),
> +		0,
> +		127 + 1,
> +		0,
> +		32,
> +		1,
> +		g_dtb4k_dtb_enq_info_queue_buf_space_left_0_127_reg,
> +		zxdh_np_write,
> +		zxdh_np_read,
> +	},
> +	{
> +		"cfg_epid_v_func_num_0_127",
> +		821,
> +		DTB4K,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_UNI_ARRAY,
> +		ZXDH_SYS_DTB_BASE_ADDR + ZXDH_MODULE_DTB_ENQ_BASE_ADDR + 0x0010,
> +		(32 / 8),
> +		0,
> +		127 + 1,
> +		0,
> +		32,
> +		7,
> +		g_dtb4k_dtb_enq_cfg_epid_v_func_num_0_127_reg,
> +		zxdh_np_write,
> +		zxdh_np_read,
> +	}
> +};
> +
> +static uint32_t
> +zxdh_np_reg_get_reg_addr(uint32_t reg_no, uint32_t m_offset, uint32_t n_offset)
> +{
> +	uint32_t	 addr		= 0;
> +	ZXDH_REG_T  *p_reg_info = NULL;
> +
> +	p_reg_info = &g_dpp_reg_info[reg_no];
> +
> +	addr = p_reg_info->addr;
> +
> +	if (p_reg_info->array_type & ZXDH_REG_UNI_ARRAY) {
> +		if (n_offset > (p_reg_info->n_size - 1))
> +			PMD_DRV_LOG(ERR, "reg n_offset is out of range, reg_no:%d, n:%d,"
> +				"size:%d", reg_no, n_offset, p_reg_info->n_size - 1);

Avoid wrapping format string instead use:
			PMD_DRV_LOG(ERR,
				"reg n_offset is out of range, reg_no:%d, n:%d size:%d", 
				reg_no, n_offset, p_reg_info->n_size - 1);

Also since m_offset and n_offset are unsigned, you should use %u not %d

> +
> +		addr += n_offset * p_reg_info->n_step;
> +	} else if (p_reg_info->array_type & ZXDH_REG_BIN_ARRAY) {
> +		if ((n_offset > (p_reg_info->n_size - 1)) || (m_offset > (p_reg_info->m_size - 1)))
> +			PMD_DRV_LOG(ERR, "reg n_offset or m_offset is out of range, reg_no:%d,"
> +				"n:%d, n_size:%d, m:%d, m_size:%d,", reg_no, n_offset,
> +				p_reg_info->n_size - 1, m_offset, p_reg_info->m_size - 1);
> +
> +		addr += m_offset * p_reg_info->m_step + n_offset * p_reg_info->n_step;
> +	}
> +
> +	return addr;
> +}
> +
>  static uint32_t
>  zxdh_np_dev_add(uint32_t  dev_id, ZXDH_DEV_TYPE_E dev_type,
>  		ZXDH_DEV_ACCESS_TYPE_E  access_type, uint64_t  pcie_addr,
> @@ -221,7 +729,10 @@ zxdh_np_dev_add(uint32_t  dev_id, ZXDH_DEV_TYPE_E dev_type,
>  	} else {
>  		/* device is new. */
>  		p_dev_info = rte_malloc(NULL, sizeof(ZXDH_DEV_CFG_T), 0);
> -		ZXDH_COMM_CHECK_DEV_POINT(dev_id, p_dev_info);
> +		if (p_dev_info == NULL) {
> +			PMD_DRV_LOG(ERR, "%s point null!", __func__);

The function name is already added by PMD_DRV_LOG

> +			return ZXDH_PAR_CHK_POINT_NULL;
> +		}
>  		p_dev_mgr->p_dev_array[dev_id] = p_dev_info;
>  		p_dev_mgr->device_num++;
>  	}
> @@ -234,6 +745,9 @@ zxdh_np_dev_add(uint32_t  dev_id, ZXDH_DEV_TYPE_E dev_type,
>  	p_dev_info->dma_vir_addr = dma_vir_addr;
>  	p_dev_info->dma_phy_addr = dma_phy_addr;
>  
> +	p_dev_info->p_pcie_write_fun = zxdh_np_dev_pcie_default_write;
> +	p_dev_info->p_pcie_read_fun  = zxdh_np_dev_pcie_default_read;
> +
>  	return 0;
>  }
>  
> @@ -335,6 +849,24 @@ zxdh_np_dtb_mgr_get(uint32_t dev_id)
>  		return p_dpp_dtb_mgr[dev_id];
>  }
>  
> +static uint32_t
> +zxdh_np_dtb_mgr_create(uint32_t dev_id)
> +{
> +	if (p_dpp_dtb_mgr[dev_id] != NULL) {
> +		PMD_DRV_LOG(ERR, "ErrorCode[0x%x]: Dma Manager"
> +			" is exist!!!", ZXDH_RC_DTB_MGR_EXIST);
> +		return ZXDH_RC_DTB_MGR_EXIST;
> +	}
> +
> +	p_dpp_dtb_mgr[dev_id] = (ZXDH_DTB_MGR_T *)rte_zmalloc(NULL, sizeof(ZXDH_DTB_MGR_T), 0);

Cast of rte_zmalloc() return is unnecessary since it returns void *.
