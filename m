Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CCFCCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 14:20:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2999440297;
	Fri, 31 Oct 2025 15:20:48 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 70DAC40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 15:20:46 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D84A8EC01E4;
 Fri, 31 Oct 2025 10:20:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 10:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1761920445; x=1762006845; bh=rn6mI08xeXxQL1hme+i+I
 dYU8DtZMnYN9rzRCzNoELY=; b=uq4Iyp2ARgohK0CfbAxuLrfN666wnwsLN0FXe
 Yue0MUVFhoONP0G5JMsKmZaoj81205NOXYKtuFSqWug2KM9EhU62Com37n/V1ZyE
 Li2CYcZTDJVwhQnRdp9Za+IYzIYezd4o6huyGj/6KTaF9Sy7Zb/w/gdbhaTIo6D4
 Y8I12pQzkcT1ppIpn7wvbLdjTqeN3EoVdCfDcGisfPmzpM5of1Rf77xf5YtG8oqQ
 GJ1wXnXmc+DIaAV89jZlr77tXDKMBIMFR2iBw1KqK8ipj0xv+22OD/YWr/Lglb+7
 9ljVyFhcBxJFYapL4h0XjAYgFF3O079Tz+aUVdGsDciTy7Fdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761920445; x=1762006845; bh=rn6mI08xeXxQL1hme+i+IdYU8DtZMnYN9rz
 RCzNoELY=; b=IogdeonweTLFwbLyA6fXzEr1Sfu08g6z8TP3t1R+Tv9pDmr30NB
 mdPfZL+3tUeoML7QNTaPV05a0ashcJpiDAPsZcNvZ7HHdPRZamObDb82PtFy48VG
 u55MOwfdB/RDDDmOWMad+0Ez4EYy8u4+OqZgZ8GTLrLgjPZOymjk9UdGzZqrIF4X
 xDINHNjdx1EJ1DVbldfghJAuXcDwDhmV1qajxj7/oJkJ83tobRoc5PT8ylHunbwy
 pdrYta6ySiAarp1JZs6euEPqnot3AIFMjc0heDmL3UrhiNtGP+8yLurasiylh2Wc
 NBbr8tNaU3jqwcBnfMT/06QwbWr34uGcfwQ==
X-ME-Sender: <xms:u8UEaXDK-oPnNBT8iczWvvBofYqkpx3bWAcA0qi6guTMn2IQpStfTQ>
 <xme:u8UEae5oA6VEDMl8DxBTNlhgNUGwr_n_KnmebyqtxOlLPnXEeWtvVDhjA_jZDpvlg
 XZa68BL2_qQ3UL3nyvirPw9jOb2oGiOGkXHvaUGPfyfg5tC1VNc7Q>
X-ME-Received: <xmr:u8UEab1A2A161nIBzxv7TtKIqOBjWq2NUFUcb1HnrVXgLuhFt8DJ97BGtKK18DEArwInVK6KCupSwCUUg4YqmDeK3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeljedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduledpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhl
 phhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkhhumhgrrh
 hksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhkohhrihesmhgrrhhvvghllhdr
 tghomhdprhgtphhtthhopehskhhothgvshhhfigrrhesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopehhkhgrlhhrrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopegtkhhm
 sehnrghprghtvggthhdrtghomhdprhgtphhtthhopehsihhlqdhplhhvsehnrghprghtvg
 gthhdrtghomh
X-ME-Proxy: <xmx:u8UEaSAVcMeswqDmY9_5eihHBSJdWTJ3hrw8GcyPtfHAIUe50xsz_w>
 <xmx:u8UEaTHI2eya6mAF1tU4P7Vt8LM_2HaHslm46CcmnqxK91x0HLTzFg>
 <xmx:u8UEaXSgpaKRIDlkbeGsCQd59IbrOwAfqC2Rpyr8PdCTXu4MV_CWFA>
 <xmx:u8UEaaPbjEMYk7pFmRV8yqFp9ujNa-zNa_4VyWp8bh1i_77kM2oG0Q>
 <xmx:vcUEabG4D10MF95sVD-vze2_GM3wnATn635qXZxraCwUx1qbupgC4B47>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 10:20:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Rosen Xu <rosen.xu@altera.com>,
 David Christensen <drc@linux.ibm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 1/1] move SPDX tag on the first line
Date: Fri, 31 Oct 2025 15:20:14 +0100
Message-ID: <20251031142018.49319-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From "Contributor's Guidelines":
"
DPDK uses first line of the file to be SPDX tag.
In case of #! scripts, SPDX tag can be placed in 2nd line of the file.
"

Some .c or .h files had the SPDX identifier on the second line
for no good reason, so it is moved to the first line
to comply with the guidelines.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-eventdev/test_pipeline_atq.c                          | 3 +--
 app/test-eventdev/test_pipeline_common.c                       | 3 +--
 app/test-eventdev/test_pipeline_common.h                       | 3 +--
 app/test-eventdev/test_pipeline_queue.c                        | 3 +--
 drivers/common/cnxk/cnxk_telemetry_bphy.c                      | 1 -
 drivers/common/cnxk/cnxk_telemetry_sso.c                       | 1 -
 drivers/net/intel/e1000/igc_filter.h                           | 3 +--
 drivers/net/ntnic/adapter/nt4ga_adapter.c                      | 3 +--
 drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c              | 3 +--
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c                  | 3 +--
 drivers/net/ntnic/include/clock_profiles_structs.h             | 3 +--
 drivers/net/ntnic/include/create_elements.h                    | 3 +--
 drivers/net/ntnic/include/flow_api.h                           | 3 +--
 drivers/net/ntnic/include/flow_api_engine.h                    | 3 +--
 drivers/net/ntnic/include/flow_filter.h                        | 3 +--
 drivers/net/ntnic/include/fpga_model.h                         | 3 +--
 drivers/net/ntnic/include/hw_mod_backend.h                     | 3 +--
 drivers/net/ntnic/include/hw_mod_cat_v18.h                     | 3 +--
 drivers/net/ntnic/include/hw_mod_cat_v21.h                     | 3 +--
 drivers/net/ntnic/include/hw_mod_flm_v25.h                     | 3 +--
 drivers/net/ntnic/include/hw_mod_hsh_v5.h                      | 3 +--
 drivers/net/ntnic/include/hw_mod_km_v7.h                       | 3 +--
 drivers/net/ntnic/include/hw_mod_pdb_v9.h                      | 3 +--
 drivers/net/ntnic/include/hw_mod_qsl_v7.h                      | 3 +--
 drivers/net/ntnic/include/hw_mod_slc_lr_v2.h                   | 3 +--
 drivers/net/ntnic/include/hw_mod_tpe_v3.h                      | 3 +--
 drivers/net/ntnic/include/nt4ga_adapter.h                      | 3 +--
 drivers/net/ntnic/include/nt4ga_filter.h                       | 3 +--
 drivers/net/ntnic/include/nt4ga_link.h                         | 3 +--
 drivers/net/ntnic/include/ntdrv_4ga.h                          | 3 +--
 drivers/net/ntnic/include/nthw_gfg.h                           | 3 +--
 drivers/net/ntnic/include/ntnic_dbs.h                          | 3 +--
 drivers/net/ntnic/include/ntnic_nim.h                          | 3 +--
 drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt200a0x.h       | 3 +--
 drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h       | 3 +--
 drivers/net/ntnic/include/ntnic_stat.h                         | 3 +--
 drivers/net/ntnic/include/ntnic_virt_queue.h                   | 3 +--
 drivers/net/ntnic/include/ntos_drv.h                           | 3 +--
 drivers/net/ntnic/include/ntos_system.h                        | 3 +--
 drivers/net/ntnic/include/stream_binary_flow_api.h             | 3 +--
 drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c        | 3 +--
 .../net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c    | 3 +--
 drivers/net/ntnic/link_mgmt/nt4ga_link.c                       | 3 +--
 drivers/net/ntnic/nim/i2c_nim.c                                | 3 +--
 drivers/net/ntnic/nim/i2c_nim.h                                | 3 +--
 drivers/net/ntnic/nim/nim_defines.h                            | 3 +--
 drivers/net/ntnic/nim/qsfp_registers.h                         | 3 +--
 .../core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_core.h                | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_fpga.h                | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_gmf.h                 | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_gpio_phy.h            | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_hif.h                 | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_i2cm.h                | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_igam.h                | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_iic.h                 | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h             | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_pca9532.h             | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h           | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_pcie3.h               | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h        | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h            | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h        | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_rmc.h                 | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_rpf.h                 | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_sdc.h                 | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h       | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_si5340.h              | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h              | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_spim.h                | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_spis.h                | 3 +--
 drivers/net/ntnic/nthw/core/include/nthw_tsm.h                 | 3 +--
 .../clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h     | 3 +--
 .../nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c      | 3 +--
 drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c      | 3 +--
 drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c | 3 +--
 .../ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c    | 3 +--
 drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c      | 3 +--
 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c | 3 +--
 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c | 3 +--
 .../ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c    | 3 +--
 drivers/net/ntnic/nthw/core/nthw_fpga.c                        | 3 +--
 drivers/net/ntnic/nthw/core/nthw_gfg.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_gmf.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_gpio_phy.c                    | 3 +--
 drivers/net/ntnic/nthw/core/nthw_hif.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_i2cm.c                        | 3 +--
 drivers/net/ntnic/nthw/core/nthw_igam.c                        | 3 +--
 drivers/net/ntnic/nthw/core/nthw_iic.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_mac_pcs.c                     | 3 +--
 drivers/net/ntnic/nthw/core/nthw_pca9532.c                     | 3 +--
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c                   | 3 +--
 drivers/net/ntnic/nthw/core/nthw_pcie3.c                       | 3 +--
 drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c                | 3 +--
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c                    | 3 +--
 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c                | 3 +--
 drivers/net/ntnic/nthw/core/nthw_rmc.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_rpf.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_sdc.c                         | 3 +--
 drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c               | 3 +--
 drivers/net/ntnic/nthw/core/nthw_si5340.c                      | 3 +--
 drivers/net/ntnic/nthw/core/nthw_spi_v3.c                      | 3 +--
 drivers/net/ntnic/nthw/core/nthw_spim.c                        | 3 +--
 drivers/net/ntnic/nthw/core/nthw_spis.c                        | 3 +--
 drivers/net/ntnic/nthw/core/nthw_tsm.c                         | 3 +--
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c                          | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_api.c                     | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h           | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c    | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_filter.c                  | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_group.c                   | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_hasher.c                  | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_hasher.h                  | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c                 | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h                 | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_id_table.c                | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_id_table.h                | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_kcc.c                     | 3 +--
 drivers/net/ntnic/nthw/flow_api/flow_km.c                      | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c        | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c            | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c            | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c            | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c             | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c            | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c            | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c         | 3 +--
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c            | 3 +--
 drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c | 3 +--
 drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h | 3 +--
 drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c | 3 +--
 drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h | 3 +--
 drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c | 3 +--
 drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h | 3 +--
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c     | 3 +--
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.h     | 3 +--
 .../flow_api/profile_inline/flow_api_profile_inline_config.h   | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c            | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h            | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c              | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h              | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h             | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c          | 3 +--
 drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h          | 3 +--
 drivers/net/ntnic/nthw/model/nthw_fpga_model.c                 | 3 +--
 drivers/net/ntnic/nthw/model/nthw_fpga_model.h                 | 3 +--
 drivers/net/ntnic/nthw/nthw_drv.h                              | 3 +--
 drivers/net/ntnic/nthw/nthw_helper.h                           | 3 +--
 drivers/net/ntnic/nthw/nthw_platform.c                         | 3 +--
 drivers/net/ntnic/nthw/nthw_platform_drv.h                     | 3 +--
 drivers/net/ntnic/nthw/nthw_rac.c                              | 3 +--
 drivers/net/ntnic/nthw/nthw_rac.h                              | 3 +--
 drivers/net/ntnic/nthw/nthw_register.h                         | 3 +--
 drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c               | 3 +--
 drivers/net/ntnic/nthw/stat/nthw_stat.c                        | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_9563_055_049_0000.c | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_instances.c         | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_instances.h         | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h          | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c       | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h       | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_param_defs.h        | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h          | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cat.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cpy.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_csu.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_dbs.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_flm.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gfg.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gmf.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gpio_phy.h | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hfu.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hif.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hsh.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_i2cm.h     | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ifr.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h     | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_iic.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ins.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_km.h       | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_pcs.h  | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_rx.h   | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_tx.h   | 3 +--
 .../net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_rd_tg.h    | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h   | 3 +--
 .../net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_wr_tg.h    | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcie3.h    | 3 +--
 .../net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdb.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h | 3 +--
 .../net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_qsl.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rac.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rmc.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpf.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpl.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpp_lr.h   | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9563.h  | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h  | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h  | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sdc.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc_lr.h   | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h     | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h     | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sta.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h     | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tsm.h      | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_cpy.h   | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_ins.h   | 3 +--
 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_rpl.h   | 3 +--
 drivers/net/ntnic/ntlog/ntlog.c                                | 3 +--
 drivers/net/ntnic/ntlog/ntlog.h                                | 3 +--
 drivers/net/ntnic/ntnic_ethdev.c                               | 3 +--
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c                  | 3 +--
 drivers/net/ntnic/ntnic_mod_reg.c                              | 3 +--
 drivers/net/ntnic/ntnic_mod_reg.h                              | 3 +--
 drivers/net/ntnic/ntnic_vfio.c                                 | 3 +--
 drivers/net/ntnic/ntnic_vfio.h                                 | 3 +--
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c                  | 3 +--
 drivers/net/ntnic/ntutil/nt_service.c                          | 3 +--
 drivers/net/ntnic/ntutil/nt_service.h                          | 3 +--
 drivers/net/ntnic/ntutil/nt_util.c                             | 3 +--
 drivers/net/ntnic/ntutil/nt_util.h                             | 3 +--
 drivers/net/ntnic/rte_pmd_ntnic.c                              | 3 +--
 drivers/net/ntnic/rte_pmd_ntnic.h                              | 3 +--
 drivers/raw/ifpga/base/opae_at24_eeprom.h                      | 1 -
 drivers/raw/ifpga/base/opae_i2c.c                              | 1 -
 examples/eventdev_pipeline/pipeline_common.h                   | 3 +--
 examples/eventdev_pipeline/pipeline_worker_generic.c           | 3 +--
 examples/eventdev_pipeline/pipeline_worker_tx.c                | 3 +--
 lib/acl/acl_run_altivec.c                                      | 3 +--
 lib/acl/acl_run_altivec.h                                      | 3 +--
 lib/eal/loongarch/rte_cpuflags.c                               | 3 +--
 lib/eal/ppc/include/rte_altivec.h                              | 3 +--
 lib/eal/ppc/include/rte_atomic.h                               | 3 +--
 lib/eal/ppc/include/rte_byteorder.h                            | 3 +--
 lib/eal/ppc/include/rte_cpuflags.h                             | 3 +--
 lib/eal/ppc/include/rte_cycles.h                               | 3 +--
 lib/eal/ppc/include/rte_memcpy.h                               | 3 +--
 lib/eal/ppc/include/rte_prefetch.h                             | 3 +--
 lib/eal/ppc/include/rte_spinlock.h                             | 3 +--
 lib/eal/ppc/include/rte_vect.h                                 | 3 +--
 lib/eal/ppc/rte_cpuflags.c                                     | 3 +--
 lib/eal/riscv/include/rte_byteorder.h                          | 3 +--
 lib/gro/gro_tcp_internal.h                                     | 1 -
 lib/ipsec/rte_ipsec_sad.h                                      | 1 -
 lib/lpm/rte_lpm_altivec.h                                      | 3 +--
 lib/meter/rte_meter.h                                          | 1 -
 276 files changed, 269 insertions(+), 545 deletions(-)

diff --git a/app/test-eventdev/test_pipeline_atq.c b/app/test-eventdev/test_pipeline_atq.c
index 4b10197127..8da01811d2 100644
--- a/app/test-eventdev/test_pipeline_atq.c
+++ b/app/test-eventdev/test_pipeline_atq.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2017 Cavium, Inc.
  */
 
diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index c1382ac188..eaf895869f 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2017 Cavium, Inc.
  */
 
diff --git a/app/test-eventdev/test_pipeline_common.h b/app/test-eventdev/test_pipeline_common.h
index cb6375f76f..61370fb799 100644
--- a/app/test-eventdev/test_pipeline_common.h
+++ b/app/test-eventdev/test_pipeline_common.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2017 Cavium, Inc.
  */
 
diff --git a/app/test-eventdev/test_pipeline_queue.c b/app/test-eventdev/test_pipeline_queue.c
index e989396474..12cb0df7bd 100644
--- a/app/test-eventdev/test_pipeline_queue.c
+++ b/app/test-eventdev/test_pipeline_queue.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2017 Cavium, Inc.
  */
 
diff --git a/drivers/common/cnxk/cnxk_telemetry_bphy.c b/drivers/common/cnxk/cnxk_telemetry_bphy.c
index 95f84888b7..03462b01cd 100644
--- a/drivers/common/cnxk/cnxk_telemetry_bphy.c
+++ b/drivers/common/cnxk/cnxk_telemetry_bphy.c
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2021 Marvell.
  */
diff --git a/drivers/common/cnxk/cnxk_telemetry_sso.c b/drivers/common/cnxk/cnxk_telemetry_sso.c
index 822934ebd7..4a135193f0 100644
--- a/drivers/common/cnxk/cnxk_telemetry_sso.c
+++ b/drivers/common/cnxk/cnxk_telemetry_sso.c
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(C) 2021 Marvell.
  */
diff --git a/drivers/net/intel/e1000/igc_filter.h b/drivers/net/intel/e1000/igc_filter.h
index 781d270def..2b7e6b619a 100644
--- a/drivers/net/intel/e1000/igc_filter.h
+++ b/drivers/net/intel/e1000/igc_filter.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2020 Intel Corporation
  */
 
diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 4599f78e3f..7ab15e356f 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 57b5b147f8..c11aa2f164 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 0fa597d777..56eb710d25 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/clock_profiles_structs.h b/drivers/net/ntnic/include/clock_profiles_structs.h
index 28a582a5e7..28a5946ffe 100644
--- a/drivers/net/ntnic/include/clock_profiles_structs.h
+++ b/drivers/net/ntnic/include/clock_profiles_structs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/create_elements.h b/drivers/net/ntnic/include/create_elements.h
index 7d9d8d1d89..a9887e748b 100644
--- a/drivers/net/ntnic/include/create_elements.h
+++ b/drivers/net/ntnic/include/create_elements.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/flow_api.h b/drivers/net/ntnic/include/flow_api.h
index 869158258e..400060a844 100644
--- a/drivers/net/ntnic/include/flow_api.h
+++ b/drivers/net/ntnic/include/flow_api.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index c166243d4b..af6806f6fc 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/flow_filter.h b/drivers/net/ntnic/include/flow_filter.h
index f325e680fb..49637f74fa 100644
--- a/drivers/net/ntnic/include/flow_filter.h
+++ b/drivers/net/ntnic/include/flow_filter.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/fpga_model.h b/drivers/net/ntnic/include/fpga_model.h
index d73cf168ed..711fa41125 100644
--- a/drivers/net/ntnic/include/fpga_model.h
+++ b/drivers/net/ntnic/include/fpga_model.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index 8d938084e9..052a35b439 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_cat_v18.h b/drivers/net/ntnic/include/hw_mod_cat_v18.h
index 7ba38207a0..987fea2046 100644
--- a/drivers/net/ntnic/include/hw_mod_cat_v18.h
+++ b/drivers/net/ntnic/include/hw_mod_cat_v18.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_cat_v21.h b/drivers/net/ntnic/include/hw_mod_cat_v21.h
index 7dd0038cf1..7058ca3aca 100644
--- a/drivers/net/ntnic/include/hw_mod_cat_v21.h
+++ b/drivers/net/ntnic/include/hw_mod_cat_v21.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_flm_v25.h b/drivers/net/ntnic/include/hw_mod_flm_v25.h
index 132a585802..b63487c2b1 100644
--- a/drivers/net/ntnic/include/hw_mod_flm_v25.h
+++ b/drivers/net/ntnic/include/hw_mod_flm_v25.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_hsh_v5.h b/drivers/net/ntnic/include/hw_mod_hsh_v5.h
index cdab15e6c2..28c2bab6c0 100644
--- a/drivers/net/ntnic/include/hw_mod_hsh_v5.h
+++ b/drivers/net/ntnic/include/hw_mod_hsh_v5.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_km_v7.h b/drivers/net/ntnic/include/hw_mod_km_v7.h
index dcc28c1812..4c74efc17f 100644
--- a/drivers/net/ntnic/include/hw_mod_km_v7.h
+++ b/drivers/net/ntnic/include/hw_mod_km_v7.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_pdb_v9.h b/drivers/net/ntnic/include/hw_mod_pdb_v9.h
index b155ee6d1e..df9de4e3fd 100644
--- a/drivers/net/ntnic/include/hw_mod_pdb_v9.h
+++ b/drivers/net/ntnic/include/hw_mod_pdb_v9.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_qsl_v7.h b/drivers/net/ntnic/include/hw_mod_qsl_v7.h
index 6f6f230638..b92c688ca2 100644
--- a/drivers/net/ntnic/include/hw_mod_qsl_v7.h
+++ b/drivers/net/ntnic/include/hw_mod_qsl_v7.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_slc_lr_v2.h b/drivers/net/ntnic/include/hw_mod_slc_lr_v2.h
index 718a3cff27..0e20448823 100644
--- a/drivers/net/ntnic/include/hw_mod_slc_lr_v2.h
+++ b/drivers/net/ntnic/include/hw_mod_slc_lr_v2.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/hw_mod_tpe_v3.h b/drivers/net/ntnic/include/hw_mod_tpe_v3.h
index 9137e69256..9d7a1ff0b4 100644
--- a/drivers/net/ntnic/include/hw_mod_tpe_v3.h
+++ b/drivers/net/ntnic/include/hw_mod_tpe_v3.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/nt4ga_adapter.h b/drivers/net/ntnic/include/nt4ga_adapter.h
index 0598e62b7b..062b6aa79d 100644
--- a/drivers/net/ntnic/include/nt4ga_adapter.h
+++ b/drivers/net/ntnic/include/nt4ga_adapter.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/nt4ga_filter.h b/drivers/net/ntnic/include/nt4ga_filter.h
index 2024b500f3..efd591a45e 100644
--- a/drivers/net/ntnic/include/nt4ga_filter.h
+++ b/drivers/net/ntnic/include/nt4ga_filter.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/nt4ga_link.h b/drivers/net/ntnic/include/nt4ga_link.h
index e3dc3d4d5d..cfd57cc951 100644
--- a/drivers/net/ntnic/include/nt4ga_link.h
+++ b/drivers/net/ntnic/include/nt4ga_link.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntdrv_4ga.h b/drivers/net/ntnic/include/ntdrv_4ga.h
index 4ff1f115f4..dce4f8452d 100644
--- a/drivers/net/ntnic/include/ntdrv_4ga.h
+++ b/drivers/net/ntnic/include/ntdrv_4ga.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/nthw_gfg.h b/drivers/net/ntnic/include/nthw_gfg.h
index 4583fd9ebd..64714a9123 100644
--- a/drivers/net/ntnic/include/nthw_gfg.h
+++ b/drivers/net/ntnic/include/nthw_gfg.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntnic_dbs.h b/drivers/net/ntnic/include/ntnic_dbs.h
index 3de7206ccb..d8fcdea174 100644
--- a/drivers/net/ntnic/include/ntnic_dbs.h
+++ b/drivers/net/ntnic/include/ntnic_dbs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntnic_nim.h b/drivers/net/ntnic/include/ntnic_nim.h
index 3e97a9a8b2..ae109e5f08 100644
--- a/drivers/net/ntnic/include/ntnic_nim.h
+++ b/drivers/net/ntnic/include/ntnic_nim.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt200a0x.h b/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt200a0x.h
index a1ee618c26..aa03319147 100644
--- a/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt200a0x.h
+++ b/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt200a0x.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h b/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
index 2f04907ac9..9dad727617 100644
--- a/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
+++ b/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntnic_stat.h b/drivers/net/ntnic/include/ntnic_stat.h
index 928c629fb2..af58538640 100644
--- a/drivers/net/ntnic/include/ntnic_stat.h
+++ b/drivers/net/ntnic/include/ntnic_stat.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntnic_virt_queue.h b/drivers/net/ntnic/include/ntnic_virt_queue.h
index 072365c946..d7fa39168d 100644
--- a/drivers/net/ntnic/include/ntnic_virt_queue.h
+++ b/drivers/net/ntnic/include/ntnic_virt_queue.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntos_drv.h b/drivers/net/ntnic/include/ntos_drv.h
index f353a5eca8..bce766ff0a 100644
--- a/drivers/net/ntnic/include/ntos_drv.h
+++ b/drivers/net/ntnic/include/ntos_drv.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/ntos_system.h b/drivers/net/ntnic/include/ntos_system.h
index 01f1dc65f4..37bfa54942 100644
--- a/drivers/net/ntnic/include/ntos_system.h
+++ b/drivers/net/ntnic/include/ntos_system.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/include/stream_binary_flow_api.h b/drivers/net/ntnic/include/stream_binary_flow_api.h
index 0678b284d4..eac8152415 100644
--- a/drivers/net/ntnic/include/stream_binary_flow_api.h
+++ b/drivers/net/ntnic/include/stream_binary_flow_api.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index 914d1c206c..0f36c30e5f 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 8bd6584b1d..f0c07c80ad 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/link_mgmt/nt4ga_link.c b/drivers/net/ntnic/link_mgmt/nt4ga_link.c
index 5e6be42398..55ced14f44 100644
--- a/drivers/net/ntnic/link_mgmt/nt4ga_link.c
+++ b/drivers/net/ntnic/link_mgmt/nt4ga_link.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 9393467904..3e81318ef9 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nim/i2c_nim.h b/drivers/net/ntnic/nim/i2c_nim.h
index 2fdfd37a03..5ab858c5fc 100644
--- a/drivers/net/ntnic/nim/i2c_nim.h
+++ b/drivers/net/ntnic/nim/i2c_nim.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nim/nim_defines.h b/drivers/net/ntnic/nim/nim_defines.h
index 8e17b263c5..5e24d63cf2 100644
--- a/drivers/net/ntnic/nim/nim_defines.h
+++ b/drivers/net/ntnic/nim/nim_defines.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nim/qsfp_registers.h b/drivers/net/ntnic/nim/qsfp_registers.h
index 13172ce30b..8cf72f65ce 100644
--- a/drivers/net/ntnic/nim/qsfp_registers.h
+++ b/drivers/net/ntnic/nim/qsfp_registers.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h b/drivers/net/ntnic/nthw/core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h
index 43664bcd8c..cb8704c113 100644
--- a/drivers/net/ntnic/nthw/core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h
+++ b/drivers/net/ntnic/nthw/core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_core.h b/drivers/net/ntnic/nthw/core/include/nthw_core.h
index 4073f9632c..9d9b593dbe 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_core.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_core.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index 532d19d6b8..17b93a5116 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_gmf.h b/drivers/net/ntnic/nthw/core/include/nthw_gmf.h
index c8beb2117c..fb14aa7fe6 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_gmf.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_gmf.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_gpio_phy.h b/drivers/net/ntnic/nthw/core/include/nthw_gpio_phy.h
index d4641cdb5d..98c9ab706d 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_gpio_phy.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_gpio_phy.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_hif.h b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
index f91f7759a7..6b1db3a985 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_hif.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_hif.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h b/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
index 1bf780d714..9235d6e84e 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_igam.h b/drivers/net/ntnic/nthw/core/include/nthw_igam.h
index fed462cd34..d60bdbd4ee 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_igam.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_igam.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_iic.h b/drivers/net/ntnic/nthw/core/include/nthw_iic.h
index f6dec4a938..c96f4f10b1 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_iic.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_iic.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h b/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h
index a4119e4efe..b702a052a2 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_mac_pcs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h b/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
index 7cc0008dcb..0510ead8fd 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
index e3dadcc8e3..fba473495c 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 #ifndef __NTHW_PCAL6416A_H__
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h b/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h
index 21b5d7d22a..efbe4de2ba 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcie3.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
index 312dfff974..5d0d297210 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 #ifndef __NTHW_PCM_NT400DXX_H__
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
index c35d39e61d..de5f611c27 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
index 53692145b7..b8386e7a45 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_rmc.h b/drivers/net/ntnic/nthw/core/include/nthw_rmc.h
index 9c40804cd9..f4c403ff3b 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_rmc.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_rmc.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_rpf.h b/drivers/net/ntnic/nthw/core/include/nthw_rpf.h
index 4916fb926e..d04c007c7e 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_rpf.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_rpf.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_sdc.h b/drivers/net/ntnic/nthw/core/include/nthw_sdc.h
index 58247d67f0..f06b6bd835 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_sdc.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_sdc.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
index 9eaf8872e3..904dba62c9 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5340.h b/drivers/net/ntnic/nthw/core/include/nthw_si5340.h
index 0e11855b92..58b34f9b7f 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_si5340.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5340.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h b/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
index 66b1f7f45d..6e522c457e 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_spim.h b/drivers/net/ntnic/nthw/core/include/nthw_spim.h
index 70a49ab627..c3fbc9abc8 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_spim.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_spim.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_spis.h b/drivers/net/ntnic/nthw/core/include/nthw_spis.h
index 978f239dd0..e6a2eb6ac4 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_spis.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_spis.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_tsm.h b/drivers/net/ntnic/nthw/core/include/nthw_tsm.h
index 0a3bcdcaf5..49aab6a5ae 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_tsm.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_tsm.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h
index a6422e321c..e2a2227d17 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
index 91c9795956..d0f6731014 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
index 20bacf8988..9b902b5675 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index c99c9ecbe6..bb860b3271 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index 39345369ef..ac1b913e94 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 47c26b092b..26c1f8c725 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 #include "ntlog.h"
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index f2b064f054..b1ad29c882 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 38614e9365..5e9f7d8653 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 #include "nthw_drv.h"
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 90d0680b99..4c3884f04b 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 7ec33aff2d..9cc8b85724 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_gfg.c b/drivers/net/ntnic/nthw/core/nthw_gfg.c
index 9cee45449b..b0c6166ef6 100644
--- a/drivers/net/ntnic/nthw/core/nthw_gfg.c
+++ b/drivers/net/ntnic/nthw/core/nthw_gfg.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_gmf.c b/drivers/net/ntnic/nthw/core/nthw_gmf.c
index 9fb708bc50..60b1c057aa 100644
--- a/drivers/net/ntnic/nthw/core/nthw_gmf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_gmf.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c b/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c
index 0fa5b15f5b..87117e0f38 100644
--- a/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c
+++ b/drivers/net/ntnic/nthw/core/nthw_gpio_phy.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_hif.c b/drivers/net/ntnic/nthw/core/nthw_hif.c
index 015dee1bcf..837ce301fd 100644
--- a/drivers/net/ntnic/nthw/core/nthw_hif.c
+++ b/drivers/net/ntnic/nthw/core/nthw_hif.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_i2cm.c b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
index 1b98fa4ca3..41886f37c9 100644
--- a/drivers/net/ntnic/nthw/core/nthw_i2cm.c
+++ b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_igam.c b/drivers/net/ntnic/nthw/core/nthw_igam.c
index 4a672daeb3..901711acd7 100644
--- a/drivers/net/ntnic/nthw/core/nthw_igam.c
+++ b/drivers/net/ntnic/nthw/core/nthw_igam.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_iic.c b/drivers/net/ntnic/nthw/core/nthw_iic.c
index 17b7c1a079..2e67738bd7 100644
--- a/drivers/net/ntnic/nthw/core/nthw_iic.c
+++ b/drivers/net/ntnic/nthw/core/nthw_iic.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
index b6c1a9a702..2acc3f5379 100644
--- a/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
+++ b/drivers/net/ntnic/nthw/core/nthw_mac_pcs.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pca9532.c b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
index 805e0275e8..e7020fc513 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pca9532.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
index f7efc196f4..578e1ea940 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcie3.c b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
index 763bf9e554..4a1d810874 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcie3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcie3.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
index e98378e154..75e7f73627 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 #include "ntlog.h"
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 8a7236d94f..dc33b28edb 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
index 286bda43f8..eef0829227 100644
--- a/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_rmc.c b/drivers/net/ntnic/nthw/core/nthw_rmc.c
index 570a179fc8..ef29c49631 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rmc.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rmc.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_rpf.c b/drivers/net/ntnic/nthw/core/nthw_rpf.c
index 7184aedc04..fa7f3142af 100644
--- a/drivers/net/ntnic/nthw/core/nthw_rpf.c
+++ b/drivers/net/ntnic/nthw/core/nthw_rpf.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_sdc.c b/drivers/net/ntnic/nthw/core/nthw_sdc.c
index a7242a8a67..437e3d1689 100644
--- a/drivers/net/ntnic/nthw/core/nthw_sdc.c
+++ b/drivers/net/ntnic/nthw/core/nthw_sdc.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
index 22c2c74a4d..967f094d36 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5340.c b/drivers/net/ntnic/nthw/core/nthw_si5340.c
index 02674c06f2..75f2fe0acb 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5340.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5340.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  *
  * This file implements Si5340 clock synthesizer support.
diff --git a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
index afa037756e..e60fe6610b 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spi_v3.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_spim.c b/drivers/net/ntnic/nthw/core/nthw_spim.c
index 42c40400d3..64b5624ade 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spim.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spim.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_spis.c b/drivers/net/ntnic/nthw/core/nthw_spis.c
index a6e0357cbc..fa04038913 100644
--- a/drivers/net/ntnic/nthw/core/nthw_spis.c
+++ b/drivers/net/ntnic/nthw/core/nthw_spis.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_tsm.c b/drivers/net/ntnic/nthw/core/nthw_tsm.c
index a748c4e1ae..323442553d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_tsm.c
+++ b/drivers/net/ntnic/nthw/core/nthw_tsm.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
index 25989d170b..aac0876812 100644
--- a/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
+++ b/drivers/net/ntnic/nthw/dbs/nthw_dbs.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 4adf847f33..a6ac76a836 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 #include "rte_spinlock.h"
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h b/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h
index 656751bbf4..0b56b7d498 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api_nic_setup.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index 567b735f1e..480030d3bd 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_filter.c b/drivers/net/ntnic/nthw/flow_api/flow_filter.c
index 9de3ed3b7a..16a1b6953f 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_filter.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_filter.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_group.c b/drivers/net/ntnic/nthw/flow_api/flow_group.c
index f2c9bcaaa5..653294192e 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_group.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_group.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hasher.c b/drivers/net/ntnic/nthw/flow_api/flow_hasher.c
index b5945831c8..2efc06deba 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hasher.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hasher.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hasher.h b/drivers/net/ntnic/nthw/flow_api/flow_hasher.h
index 631a12a8d9..b2e62588d7 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hasher.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hasher.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
index 9a7069194b..06a8bcd185 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
index 124225c455..1b85ae7446 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_hsh_cfg.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
index f7c983fb9f..8fdaf66550 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_id_table.h b/drivers/net/ntnic/nthw/flow_api/flow_id_table.h
index 99789955bc..49ef1b8377 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_id_table.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_id_table.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_kcc.c b/drivers/net/ntnic/nthw/flow_api/flow_kcc.c
index 47311729ea..516ebbcc3d 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_kcc.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_kcc.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index 4ccd77895b..e1c3d0050c 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
index 21aa49e952..ccb1e21677 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_backend.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
index df9338052e..bbd7774007 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
index b2cb82daab..8b9d57ea2a 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
index a76cec5cfd..1a5f3e3e67 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
index 81de05253f..066d3f9349 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_km.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
index 8bfc5fa9a1..95c89b08ea 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
index c7c56ef94f..5942e55a11 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
index 20ce217614..918ebf4108 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_slc_lr.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
index b65e37ce7b..4ac0e9daac 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
index 87c1a5a29e..b9c93a293c 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h
index babf73fd7f..69dd918c74 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
index 4693671809..e2f3b31ad0 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
index db309bfb6e..a902bd3fd9 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
index 4f974a6e5b..cb4504a6e0 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h
index ee1e2a63eb..75093e49fe 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index a7f96cf451..2a5808cfe4 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
index 86e867b728..94f34db199 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h
index 4be5740f1a..ed8f262c91 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline_config.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
index bc3c9ed8a7..9d2fc3d58c 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h
index 13dddfd96e..4514bc6806 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_cat.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
index 6054b611cd..8480ad5d9c 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h
index 0f94761d41..9171cdfdf2 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
index 0fa6d918ae..9b4386ae48 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h
index de537c9e49..4d0f3e350e 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
index 6e46fee637..72ff92a03d 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h
index a41ff4c8b8..335542e11f 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hfu.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
index fc1ca7aba2..2477a411bf 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h
index 0cd9a365fe..5c66112f1e 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
index ee77e21694..8626580161 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
index eaf955a25f..eff0fc7037 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_ifr.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
index 812c265cda..cb0b0a2f04 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h
index 49c5c9ce7d..66b8186a20 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
index 0d6dabed46..c8cdeee93a 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h
index 9278c60241..f9f74523f2 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_km.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
index 664d2d1dea..043bc86137 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h
index bd220ed8d7..f27239bb30 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_pdb.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
index d82a22ba8a..ce17fede53 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h
index b57546a09c..3bf28eb6ea 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index 07e6d38731..a3f441c9f3 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h
index e68df10cc2..edfd625dc2 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
index afe5597962..0091f47d27 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h
index 6e8860d3dc..82e6c36726 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_slc_lr.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
index 9841a9a7b8..7be964f371 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h
index c3b3129fa5..cd0a6850fb 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
index 63ead6c925..d5f8857596 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h
index b58f3d2e28..a0dc862884 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_ins.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
index 4eb2e69e78..1c67b115b1 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h
index 77fe9373ee..49f0994372 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
index 1dc604fe65..23822fabcc 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/model/nthw_fpga_model.h b/drivers/net/ntnic/nthw/model/nthw_fpga_model.h
index 459c9f081d..cb60284e89 100644
--- a/drivers/net/ntnic/nthw/model/nthw_fpga_model.h
+++ b/drivers/net/ntnic/nthw/model/nthw_fpga_model.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 90f4bdb679..d421496241 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_helper.h b/drivers/net/ntnic/nthw/nthw_helper.h
index 25a8d2a947..248bff8421 100644
--- a/drivers/net/ntnic/nthw/nthw_helper.h
+++ b/drivers/net/ntnic/nthw/nthw_helper.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_platform.c b/drivers/net/ntnic/nthw/nthw_platform.c
index 83e1b38563..b52b34fd1f 100644
--- a/drivers/net/ntnic/nthw/nthw_platform.c
+++ b/drivers/net/ntnic/nthw/nthw_platform.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_platform_drv.h b/drivers/net/ntnic/nthw/nthw_platform_drv.h
index a861c8dd7b..27c72fd3b7 100644
--- a/drivers/net/ntnic/nthw/nthw_platform_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_platform_drv.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index a2a96794da..4135061541 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_rac.h b/drivers/net/ntnic/nthw/nthw_rac.h
index df92b487af..7159f67ea7 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.h
+++ b/drivers/net/ntnic/nthw/nthw_rac.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/nthw_register.h b/drivers/net/ntnic/nthw/nthw_register.h
index ecc661a656..e125d4c516 100644
--- a/drivers/net/ntnic/nthw/nthw_register.h
+++ b/drivers/net/ntnic/nthw/nthw_register.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
index 95a875fc1a..9683797647 100644
--- a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
+++ b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index 9bb97bf311..c085055586 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_9563_055_049_0000.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_9563_055_049_0000.c
index f1033ca949..d3a65be6f0 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_9563_055_049_0000.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_9563_055_049_0000.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c
index 6482c806ae..38365c7bf9 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_9569_055_049_0000.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c
index 700012ca06..33531244cc 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.c
index 3a8c1d78c8..b26a081a2d 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.h
index 41aade2340..bc677047c5 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_instances.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h
index 8d5837bac1..ef9c87feb9 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
index 816d4ff781..42b5004ab0 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h
index a6da8912b1..fae6ec7789 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_param_defs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_param_defs.h
index d2644e1765..a28df6210b 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_param_defs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_param_defs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h
index c16beb5faf..a73ac2baff 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cat.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cat.h
index cafed8a4bc..a55664d519 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cat.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cat.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cpy.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cpy.h
index 55fd5704b9..c5caf4ed7a 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cpy.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_cpy.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_csu.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_csu.h
index a67f1c392e..f98d3aaa36 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_csu.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_csu.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_dbs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_dbs.h
index 0c7bbd8efd..d859545837 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_dbs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_dbs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_flm.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_flm.h
index 1f8678779e..0fdce82dea 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_flm.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_flm.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gfg.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gfg.h
index c9a586ec3c..e52d388a80 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gfg.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gfg.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gmf.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gmf.h
index 0ebbec6c8c..9afb997db3 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gmf.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gmf.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gpio_phy.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gpio_phy.h
index d540292e0f..c006aedf10 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gpio_phy.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_gpio_phy.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hfu.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hfu.h
index 1334e55ef3..1f9e7ae793 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hfu.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hfu.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hif.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hif.h
index 294672d34d..758b641732 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hif.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hif.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hsh.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hsh.h
index fb95a514de..eba3715164 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hsh.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_hsh.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_i2cm.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_i2cm.h
index 0bb0d90eb2..f472b3e866 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_i2cm.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_i2cm.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ifr.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ifr.h
index 5636e94e07..1d8e71d0d2 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ifr.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ifr.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h
index dd247ef0dd..f48f4b6566 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_iic.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_iic.h
index 4b800aa3b4..c6d255babd 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_iic.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_iic.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ins.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ins.h
index 8aaef2a8f6..2532a242cd 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ins.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_ins.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_km.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_km.h
index 03273dced0..7315c3aee4 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_km.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_km.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_pcs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_pcs.h
index c5f3cf4613..c843c85e02 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_pcs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_pcs.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_rx.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_rx.h
index 3829c10f3b..b421b09cc5 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_rx.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_rx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_tx.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_tx.h
index 6a77d449ae..2c7f35251c 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_tx.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_mac_tx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_rd_tg.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_rd_tg.h
index 46ce0afa9c..6f998a2d58 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_rd_tg.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_rd_tg.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h
index d9a0b4f381..d782e4a61f 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_wr_tg.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_wr_tg.h
index 884437d8b0..01df42660e 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_wr_tg.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_wr_tg.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcie3.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcie3.h
index 6e57f7d231..b5024d1088 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcie3.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcie3.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h
index fadb8c17e8..646d7b0068 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdb.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdb.h
index 98887ffccb..de487af2ce 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdb.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdb.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h
index 67177ca288..903c4ff6e0 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h
index 99ef0e21fc..86e337e452 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h
index 7855c9cab5..2fefa1d6c3 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_qsl.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_qsl.h
index 6a15ddc00e..039b54ab38 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_qsl.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_qsl.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rac.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rac.h
index cce58e0c96..dfaecf975b 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rac.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rac.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h
index 18b67f4032..fd5a2a3498 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rmc.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rmc.h
index 07a1c8f890..4080f33867 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rmc.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rmc.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpf.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpf.h
index 72f450b85d..5eff6ea531 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpf.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpf.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpl.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpl.h
index a163ffc45e..2918f687c6 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpl.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpl.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpp_lr.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpp_lr.h
index f84cdf5939..5a8d7dd3c4 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpp_lr.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rpp_lr.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9563.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9563.h
index e03e3fbb2e..929e2da2e2 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9563.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9563.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h
index 27e52b0b85..87b973e79e 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h
index 90aeaec3a4..3d8cf9517d 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sdc.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sdc.h
index da0092500b..8cec0c06f4 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sdc.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sdc.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc.h
index 11a8ef79a1..de8bdc0831 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc_lr.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc_lr.h
index ef1f358cb3..148f57a8e7 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc_lr.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_slc_lr.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h
index 5adeaea1ec..9dcdf0ba8a 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h
index 11785d74b7..51ed8d5a26 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sta.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sta.h
index 0cd183fcaa..071258c914 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sta.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_sta.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h
index acfc07a1b6..881b3ab0cd 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tsm.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tsm.h
index cdb733ee17..722c6b11ab 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tsm.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tsm.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_cpy.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_cpy.h
index 1fb71bf483..45a04fe8b0 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_cpy.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_cpy.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_ins.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_ins.h
index 26635bd0a2..849991d768 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_ins.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_ins.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_rpl.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_rpl.h
index 8c46079cd5..1db016bd5f 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_rpl.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tx_rpl.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2024 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntlog/ntlog.c b/drivers/net/ntnic/ntlog/ntlog.c
index 1ee0f40286..6e98f3bf2c 100644
--- a/drivers/net/ntnic/ntlog/ntlog.c
+++ b/drivers/net/ntnic/ntlog/ntlog.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntlog/ntlog.h b/drivers/net/ntnic/ntlog/ntlog.h
index 63489e38b8..7a9d7b468a 100644
--- a/drivers/net/ntnic/ntlog/ntlog.h
+++ b/drivers/net/ntnic/ntlog/ntlog.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index f8a01dc9fc..23c3452d2d 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index f1c7fe22e0..cace4f1f71 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index ab29a2d816..5313d1bb7a 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 241fcabddb..81ba1e44f9 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 187829d287..439468b3a2 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_vfio.h b/drivers/net/ntnic/ntnic_vfio.h
index 72f8165a48..be45423313 100644
--- a/drivers/net/ntnic/ntnic_vfio.h
+++ b/drivers/net/ntnic/ntnic_vfio.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index ab3f144fa2..aa78244bc7 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
index c39771acc2..5bfc654340 100644
--- a/drivers/net/ntnic/ntutil/nt_service.c
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntutil/nt_service.h b/drivers/net/ntnic/ntutil/nt_service.h
index 73c9076c2e..06547199ae 100644
--- a/drivers/net/ntnic/ntutil/nt_service.h
+++ b/drivers/net/ntnic/ntutil/nt_service.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index 2401aee3dc..8014b218b5 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/ntutil/nt_util.h b/drivers/net/ntnic/ntutil/nt_util.h
index c889d07a10..e904b192f4 100644
--- a/drivers/net/ntnic/ntutil/nt_util.h
+++ b/drivers/net/ntnic/ntutil/nt_util.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.c b/drivers/net/ntnic/rte_pmd_ntnic.c
index fcc06a1ea0..2e6da21bab 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.c
+++ b/drivers/net/ntnic/rte_pmd_ntnic.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2025 Napatech A/S
  */
 
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index 3a5131eb73..a996326ef7 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
 
diff --git a/drivers/raw/ifpga/base/opae_at24_eeprom.h b/drivers/raw/ifpga/base/opae_at24_eeprom.h
index caae9a3ec1..ed5468ffd5 100644
--- a/drivers/raw/ifpga/base/opae_at24_eeprom.h
+++ b/drivers/raw/ifpga/base/opae_at24_eeprom.h
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2019 Intel Corporation
  */
diff --git a/drivers/raw/ifpga/base/opae_i2c.c b/drivers/raw/ifpga/base/opae_i2c.c
index 598eab5742..c141307fc3 100644
--- a/drivers/raw/ifpga/base/opae_i2c.c
+++ b/drivers/raw/ifpga/base/opae_i2c.c
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2019 Intel Corporation
  */
diff --git a/examples/eventdev_pipeline/pipeline_common.h b/examples/eventdev_pipeline/pipeline_common.h
index 21b4c7ef49..7b8eb50240 100644
--- a/examples/eventdev_pipeline/pipeline_common.h
+++ b/examples/eventdev_pipeline/pipeline_common.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2016 Intel Corporation.
  * Copyright 2017 Cavium, Inc.
  */
diff --git a/examples/eventdev_pipeline/pipeline_worker_generic.c b/examples/eventdev_pipeline/pipeline_worker_generic.c
index 06384c683c..c0de5b1e11 100644
--- a/examples/eventdev_pipeline/pipeline_worker_generic.c
+++ b/examples/eventdev_pipeline/pipeline_worker_generic.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2016 Intel Corporation.
  * Copyright 2017 Cavium, Inc.
  */
diff --git a/examples/eventdev_pipeline/pipeline_worker_tx.c b/examples/eventdev_pipeline/pipeline_worker_tx.c
index c9a04cad56..f7b7937d6a 100644
--- a/examples/eventdev_pipeline/pipeline_worker_tx.c
+++ b/examples/eventdev_pipeline/pipeline_worker_tx.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2014 Intel Corporation
  * Copyright 2017 Cavium, Inc.
  */
diff --git a/lib/acl/acl_run_altivec.c b/lib/acl/acl_run_altivec.c
index fc26d1c549..9ff1b3fdd1 100644
--- a/lib/acl/acl_run_altivec.c
+++ b/lib/acl/acl_run_altivec.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2016.
  */
 
diff --git a/lib/acl/acl_run_altivec.h b/lib/acl/acl_run_altivec.h
index d5ccdb94f0..0ecb40f247 100644
--- a/lib/acl/acl_run_altivec.h
+++ b/lib/acl/acl_run_altivec.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2016.
  */
 
diff --git a/lib/eal/loongarch/rte_cpuflags.c b/lib/eal/loongarch/rte_cpuflags.c
index 19fbf37e3e..62207a4e0a 100644
--- a/lib/eal/loongarch/rte_cpuflags.c
+++ b/lib/eal/loongarch/rte_cpuflags.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2022 Loongson Technology Corporation Limited
  */
 
diff --git a/lib/eal/ppc/include/rte_altivec.h b/lib/eal/ppc/include/rte_altivec.h
index bc8548f11e..bf39e7bbab 100644
--- a/lib/eal/ppc/include/rte_altivec.h
+++ b/lib/eal/ppc/include/rte_altivec.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) Mellanox 2020.
  */
 
diff --git a/lib/eal/ppc/include/rte_atomic.h b/lib/eal/ppc/include/rte_atomic.h
index 6ce2e5188a..10acc238f9 100644
--- a/lib/eal/ppc/include/rte_atomic.h
+++ b/lib/eal/ppc/include/rte_atomic.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Inspired from FreeBSD src/sys/powerpc/include/atomic.h
  * Copyright (c) 2021 IBM Corporation
  * Copyright (c) 2008 Marcel Moolenaar
diff --git a/lib/eal/ppc/include/rte_byteorder.h b/lib/eal/ppc/include/rte_byteorder.h
index 1d19e96f72..6c11fce9dc 100644
--- a/lib/eal/ppc/include/rte_byteorder.h
+++ b/lib/eal/ppc/include/rte_byteorder.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Inspired from FreeBSD src/sys/powerpc/include/endian.h
  * Copyright (c) 1987, 1991, 1993
  * The Regents of the University of California.  All rights reserved.
diff --git a/lib/eal/ppc/include/rte_cpuflags.h b/lib/eal/ppc/include/rte_cpuflags.h
index fda7075a2d..631e12f6e8 100644
--- a/lib/eal/ppc/include/rte_cpuflags.h
+++ b/lib/eal/ppc/include/rte_cpuflags.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2014.
  */
 
diff --git a/lib/eal/ppc/include/rte_cycles.h b/lib/eal/ppc/include/rte_cycles.h
index 1e6e6cccc8..ec0c450b1f 100644
--- a/lib/eal/ppc/include/rte_cycles.h
+++ b/lib/eal/ppc/include/rte_cycles.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2014.
  */
 
diff --git a/lib/eal/ppc/include/rte_memcpy.h b/lib/eal/ppc/include/rte_memcpy.h
index eae73128c4..2fc2d2b2bc 100644
--- a/lib/eal/ppc/include/rte_memcpy.h
+++ b/lib/eal/ppc/include/rte_memcpy.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2014,2021
  */
 
diff --git a/lib/eal/ppc/include/rte_prefetch.h b/lib/eal/ppc/include/rte_prefetch.h
index bae95af7bf..6fd0b64e0c 100644
--- a/lib/eal/ppc/include/rte_prefetch.h
+++ b/lib/eal/ppc/include/rte_prefetch.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2014.
  */
 
diff --git a/lib/eal/ppc/include/rte_spinlock.h b/lib/eal/ppc/include/rte_spinlock.h
index 77f90f974a..6d242db35d 100644
--- a/lib/eal/ppc/include/rte_spinlock.h
+++ b/lib/eal/ppc/include/rte_spinlock.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2014.
  */
 
diff --git a/lib/eal/ppc/include/rte_vect.h b/lib/eal/ppc/include/rte_vect.h
index c8bace2d75..20b366b4e9 100644
--- a/lib/eal/ppc/include/rte_vect.h
+++ b/lib/eal/ppc/include/rte_vect.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2016.
  */
 
diff --git a/lib/eal/ppc/rte_cpuflags.c b/lib/eal/ppc/rte_cpuflags.c
index a78a7d1b53..f634ce5925 100644
--- a/lib/eal/ppc/rte_cpuflags.c
+++ b/lib/eal/ppc/rte_cpuflags.c
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2014.
  */
 
diff --git a/lib/eal/riscv/include/rte_byteorder.h b/lib/eal/riscv/include/rte_byteorder.h
index c9ff5c0dd1..643d89cafe 100644
--- a/lib/eal/riscv/include/rte_byteorder.h
+++ b/lib/eal/riscv/include/rte_byteorder.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Inspired from FreeBSD src/sys/powerpc/include/endian.h
  * Copyright(c) 1987, 1991, 1993
  * The Regents of the University of California.  All rights reserved.
diff --git a/lib/gro/gro_tcp_internal.h b/lib/gro/gro_tcp_internal.h
index e4855da1ad..d808a4012e 100644
--- a/lib/gro/gro_tcp_internal.h
+++ b/lib/gro/gro_tcp_internal.h
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Intel Corporation
  */
diff --git a/lib/ipsec/rte_ipsec_sad.h b/lib/ipsec/rte_ipsec_sad.h
index c7fb474430..8547630ae4 100644
--- a/lib/ipsec/rte_ipsec_sad.h
+++ b/lib/ipsec/rte_ipsec_sad.h
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Intel Corporation
  */
diff --git a/lib/lpm/rte_lpm_altivec.h b/lib/lpm/rte_lpm_altivec.h
index bab8929495..30ac94f822 100644
--- a/lib/lpm/rte_lpm_altivec.h
+++ b/lib/lpm/rte_lpm_altivec.h
@@ -1,5 +1,4 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
+/* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C) IBM Corporation 2016.
  */
 
diff --git a/lib/meter/rte_meter.h b/lib/meter/rte_meter.h
index e72bf93b3e..ab2380c154 100644
--- a/lib/meter/rte_meter.h
+++ b/lib/meter/rte_meter.h
@@ -1,4 +1,3 @@
-
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2014 Intel Corporation
  */
-- 
2.51.0

