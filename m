Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B9C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 23:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15253402A8;
	Fri, 21 Feb 2025 00:49:56 +0100 (CET)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by mails.dpdk.org (Postfix) with ESMTP id 134E34026D
 for <dev@dpdk.org>; Fri, 21 Feb 2025 00:49:53 +0100 (CET)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-520a48f37b4so820587e0c.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 15:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740095393;
 x=1740700193; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rtTIX6pNAXfM4tJAkekOaYylMnRb1uWClgk4qZhkgcY=;
 b=AUy+a1MciZ0j1wm1UaCC3am3CqnST1IacHmfCpZdzJyh7kShXCUxKvXBCzRxj+XVma
 HGFkbpiw+Y7aNEj7XYRHDqxv+OP4H38qrnGNUDheW9xrZuiuHgPD34217ABn26OW8OHF
 elvkHMEl4BjXQg6q0E38qZvrDx3cYKAxUVtt30Eo/zAQEOKj2WjuObm+EzQkxV+JJ7Ru
 F/va2YAKWbfyf85+hysaJfHne7bck/uvCnyuDQK3G//ztDudUjufpQJtbU13fVd0c7eE
 uZfcE2Q1a7/sv3EWu3rgEponyudyYQ9KnIFDKVUq5oIPV8FQSzLYkFiGvsWfiACdE4UW
 VIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740095393; x=1740700193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rtTIX6pNAXfM4tJAkekOaYylMnRb1uWClgk4qZhkgcY=;
 b=LYzVTtzUG0ws5K2Lill0ZpxOj7wUkfo5EqXliDfC2WD7pfqFACbErokOLKMbRuAMR6
 GLcTxlOUmAUutGlnQPHPFrmdgAVGXlAqbfX6dsprYWBlDOZKTojxILCLsgX8hDLk+GF5
 Ra6J7xDS8TTTg5Mn2gDt8Bpr+drWZuu0bQH871Rpe7kArhX8h4rZ8uw7dyxTdSkFrdKc
 K3+W+KCuE/L5Mjhlu0rM3hfiuI3dOg70jG2CLEcQcEUj/hF4wV7XcUeEhuUJFflZ+45V
 OqKIlCcYzu6pRfRBeiMOitGRYQbUcXjBcLrktewf/SQrCG/fFWbbpr5LCTy5K45s0B7d
 /Gxg==
X-Gm-Message-State: AOJu0Yx1c9LojA6AvtPq/jeHshPGqmnjg1T4zl4q2o7Atv4iWWr6JEID
 BTfpxLFl1UKR86/UKtKiSV5zS5Bnr3bDyz2kuo/U8wAYzOaPnjEL01rh5GoX16Z+FCue6K58rsS
 1e6JKqiom7EOZUa5DG17cPnc9pVRN+MZAg38X1Q==
X-Gm-Gg: ASbGncs5wPdUqMMTCCDyEynsWZz6TfaHtxWZU62uYEWYIn7VI7e/1uMWFMa1G4WhzpY
 yXWdwkE3Nk4ichwKFg8CXmfmk01tySFiP6GVnPDu6iVSokGQGOLp3jREkLSZOBCa8JkiLO+RF7A
 ==
X-Google-Smtp-Source: AGHT+IHf4DSNpEK1Q9aqf6zzEG5xM6FHLryGEHq6g7cPJlxq1PcTE3MV71Pqv+LD7inURgwibfwb476dlwQtWcr1Wpg=
X-Received: by 2002:a05:6122:553:b0:51b:8949:c9a8 with SMTP id
 71dfb90a1353d-521efcf42a8mr437241e0c.9.1740095392717; Thu, 20 Feb 2025
 15:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20250220220406.3925597-1-sil-plv@napatech.com>
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 20 Feb 2025 15:49:41 -0800
X-Gm-Features: AWEUYZnDjjKVLqK0iRiH-8vJZcBJssm4R5jwlR8w5NBEHdOa8W0z3u0N6V4QG04
Message-ID: <CAOaVG170qdNxDFsTjCvJhZafY-Fs8e98xPBa3q8U--WX+K_Qvw@mail.gmail.com>
Subject: Re: [PATCH v1 00/32] add new adapter NT400D13
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Content-Type: multipart/alternative; boundary="000000000000c2332c062e9b87fd"
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

--000000000000c2332c062e9b87fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, scan of ntnic with PVS studio after this bundle.
Similar to Coverity it is a good automated tool for finding bugs.

MESSAGES
LocationCodeMessage
Fails/Info

nt4ga_adapter.c (129)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function.
Under certain conditions the pointer can be null.

nt4ga_adapter.c (150)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function.
Under certain conditions the pointer can be null.

nt4ga_stat.c (252)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'p_nt4ga_stat'
pointer was utilized before it was verified against nullptr. Check lines:
252, 259.

nt4ga_stat.c (47)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'p_nt4ga_stat' is always true.

ntnic_dbsconfig.c (595)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'txvq' pointer was
utilized before it was verified against nullptr. Check lines: 595, 597.

ntnic_dbsconfig.c (765)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'irq_vector
>=3D 0' is always false.

ntnic_dbsconfig.c (400)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

hw_mod_backend.h (750)
V1071 <https://pvs-studio.com/en/docs/warnings/v1071/> Consider inspecting
the 'hw_mod_hsh_rcp_set' function. The return value is not always used.
Total calls: 15, discarded results: 1.

nt4ga_link_100g.c (259)
V781 <https://pvs-studio.com/en/docs/warnings/v781/> The value of the
'port' variable is checked after it was used. Perhaps there is a mistake in
program logic. Check lines: 259, 261.

nt4ga_link_100g.c (674)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always true: res =3D=3D 0.

nt4ga_agx_link_100g.c (696)
V523 <https://pvs-studio.com/en/docs/warnings/v523/> The 'then' statement
is equivalent to the 'else' statement.

nt4ga_agx_link_100g.c (1012)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'res =3D=3D=
 0'
is always true.

nt4ga_agx_link_100g.c (1021)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'res =3D=3D=
 0'
is always true.

nt4ga_agx_link_100g.c (522)
V781 <https://pvs-studio.com/en/docs/warnings/v781/> The value of the
'port' variable is checked after it was used. Perhaps there is a mistake in
program logic. Check lines: 522, 524.

nt4ga_agx_link_100g.c (916)
V619 <https://pvs-studio.com/en/docs/warnings/v619/> The array 'nim_ctx' is
being utilized as a pointer to single object.

nt4ga_agx_link_100g.c (318)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (370)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (370)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (385)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (391)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (976)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (984)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

nt4ga_agx_link_100g.c (380)
V1051 <https://pvs-studio.com/en/docs/warnings/v1051/> Consider checking
for misprints. It's possible that the 'state->link_up' should be checked
here.

i2c_nim.c (126)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'multi_byte
=3D=3D 1' is always true.

i2c_nim.c (881)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
880, 881.

nthw_fpga_rst9563.c (62)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The
'p->mp_fld_rst_ptp' variable is assigned values twice successively. Perhaps
this is a mistake. Check lines: 61, 62.

nthw_fpga_rst9563.c (107)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'!p->mp_fld_stat_tsm_ref_mmcm_locked' is always true.

nthw_fpga_rst9563.c (129)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'!p->mp_fld_sticky_tsm_ref_mmcm_unlocked' is always true.

nthw_fpga_rst_nt200a0x.c (531)
V519 <https://pvs-studio.com/en/docs/warnings/v519/> The 'res' variable is
assigned values twice successively. Perhaps this is a mistake. Check lines:
530, 531.

nthw_fpga_rst_nt200a0x.c (62)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_fpga_rst_nt200a0x.c (72)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_fpga_nt400dxx.c (187)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'rst9574_ops' is always true.

nthw_fpga_rst_nt400dxx.c (185)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'p_fpga_info'
pointer was utilized before it was verified against nullptr. Check lines:
185, 194.

nthw_fpga_rst_nt400dxx.c (60)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'nthw_prm_nt400dxx_platform_rst',
'nthw_prm_nt400dxx_periph_rst', 'nthw_prm_nt400dxx_periph_rst' in lines 60,
64, 66.

nthw_fpga_rst_nt400dxx.c (116)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items '0', '1', '0', '0', '1' in lines
116, 122, 128, 134, 140.

nthw_fpga.c (623)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'p_fpga_info'
pointer was utilized before it was verified against nullptr. Check lines:
623, 639.

nthw_fpga.c (317)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: avr_vpd_info.n_avr_spi_version >=3D 3.

nthw_fpga.c (387)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: avr_vpd_info.n_avr_spi_version >=3D 3.

nthw_fpga.c (469)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: avr_vpd_info.n_avr_spi_version >=3D 3.

nthw_fpga.c (831)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always true: p_fpga_info.

nthw_fpga.c (831)
V571 <https://pvs-studio.com/en/docs/warnings/v571/> Recurring check. The
'p_fpga_info' condition was already verified in line 830.

nthw_fpga.c (524)
V1086 <https://pvs-studio.com/en/docs/warnings/v1086/> A call of the
'memcpy' function will lead to underflow of the buffer '&
p_vpd_board_info[0]'.

nthw_hif.c (27)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_hif.c (82)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

nthw_iic.c (257)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_iic.c (242)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

nthw_pcie3.c (28)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_pcm_nt400dxx.c (45)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'nthw_register_query_field',
'nthw_register_get_field', 'nthw_register_get_field' in lines 45, 49, 53.

nthw_phy_tile.c (821)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'i =3D=3D 0=
' is
always false.

nthw_phy_tile.c (800)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The 'xcvr_instance'
variable was assigned the same value.

nthw_phy_tile.c (86)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

nthw_rpf.c (26)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_sdc.c (26)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_sdc.c (135)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'pn_result_mask' is always true.

nthw_si5340.c (48)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_spi_v3.c (140)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_spi_v3.c (148)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_spi_v3.c (154)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_spi_v3.c (159)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_tsm.c (92)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'p_ts' is
always true.

nthw_tsm.c (111)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'p_time' is
always true.

flow_api.c (833)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'ndev' is
always true.

flow_api.c (999)
V1029 <https://pvs-studio.com/en/docs/warnings/v1029/> Numeric Truncation
Error. Return value of the 'strlen' function is written to the 16-bit
variable.

flow_api.c (1001)
V1029 <https://pvs-studio.com/en/docs/warnings/v1029/> Numeric Truncation
Error. Return value of the 'strlen' function is written to the 16-bit
variable.

flow_api.c (214)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

flow_api.c (227)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

flow_api.c (428)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

flow_group.c (35)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'group_handle'. Check lines: 35,
32.

flow_hsh_cfg.c (74)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

flow_hsh_cfg.c (77)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

flow_id_table.c (71)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'handle'. Check lines: 71, 69.

flow_km.c (583)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

flow_km.c (614)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The SIGNED integer type argument is expected.

flow_km.c (791)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

flow_km.c (92)
V769 <https://pvs-studio.com/en/docs/warnings/v769/> The '(char *)
km->cam_dist' pointer in the expression could be nullptr. In such case,
resulting value of arithmetic operations on this pointer will be senseless
and it should not be used. Check lines: 92, 85.

hw_mod_flm.c (836)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression
'be->flm.ver < 18' is always false.

hw_mod_hsh.c (127)
V568 <https://pvs-studio.com/en/docs/warnings/v568/> It's odd that
'sizeof()' operator evaluates the size of a pointer to a class, but not the
size of the 'be->hsh.v5.rcp' class object.

hw_mod_hsh.c (130)
V1064 <https://pvs-studio.com/en/docs/warnings/v1064/> The 'buffer_size'
operand of integer division is less than the 'element_size' one. The result
will always be zero.

hw_mod_hsh.c (133)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: index < max_idx. Unsigned type value is never <
0.

hw_mod_hsh.c (133)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: word_off < max_idx. Unsigned type value is
never < 0.

hw_mod_pdb.c (137)
V568 <https://pvs-studio.com/en/docs/warnings/v568/> It's odd that
'sizeof()' operator evaluates the size of a pointer to a class, but not the
size of the 'be->pdb.v9.rcp' class object.

hw_mod_pdb.c (140)
V1064 <https://pvs-studio.com/en/docs/warnings/v1064/> The 'buffer_size'
operand of integer division is less than the 'element_size' one. The result
will always be zero.

hw_mod_pdb.c (143)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: * value < max_idx. Unsigned type value is never
< 0.

hw_mod_pdb.c (143)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: index < max_idx. Unsigned type value is never <
0.

flm_evt_queue.c (194)
V557 <https://pvs-studio.com/en/docs/warnings/v557/> Array overrun is
possible. The value of 'port' index could reach 127.

flm_evt_queue.c (202)
V557 <https://pvs-studio.com/en/docs/warnings/v557/> Array overrun is
possible. The value of 'port' index could reach 127.

flm_evt_queue.c (80)
V1037 <https://pvs-studio.com/en/docs/warnings/v1037/> Two or more
case-branches perform the same actions. Check lines: 80, 88

flm_evt_queue.c (84)
V1037 <https://pvs-studio.com/en/docs/warnings/v1037/> Two or more
case-branches perform the same actions. Check lines: 84, 92

flow_api_hw_db_inline.c (2461)
V1086 <https://pvs-studio.com/en/docs/warnings/v1086/> A call of the
'memset' function will lead to underflow of the buffer '&
db->flm[idx.id1].data'.

flow_api_hw_db_inline.c (426)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (428)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (428)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (428)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (428)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (438)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (446)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (455)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (457)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the eighth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (457)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (457)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (457)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'fprintf' function.
The SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (457)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (457)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (467)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (482)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (494)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (509)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (518)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (526)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (560)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (578)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (579)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (579)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (579)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (579)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (581)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (581)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (581)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (581)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (583)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (583)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
integer argument of 32-bit size is expected.

flow_api_hw_db_inline.c (596)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (604)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (610)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (618)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (619)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (620)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (621)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (627)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (628)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (629)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fourth actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (629)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (636)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the third actual argument of the 'fprintf' function. The
SIGNED integer type argument is expected.

flow_api_hw_db_inline.c (706)
V1037 <https://pvs-studio.com/en/docs/warnings/v1037/> Two or more
case-branches perform the same actions. Check lines: 706, 736, 742

flow_api_profile_inline.c (117)
V629 <https://pvs-studio.com/en/docs/warnings/v629/> Consider inspecting
the '1 << (shift - 1)' expression. Bit shifting of the 32-bit value with a
subsequent expansion to the 64-bit type.

flow_api_profile_inline.c (738)
V674 <https://pvs-studio.com/en/docs/warnings/v674/> The '0.01' literal of
the 'double' type is compared to a value of the 'int' type. Consider
inspecting the '0.01 > 0' expression.

flow_api_profile_inline.c (3469)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'fh'. Check lines: 3469, 3467.

flow_api_profile_inline.c (4925)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'template'. Check lines: 4925,
4923.

flow_api_profile_inline.c (4990)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'template'. Check lines: 4990,
4988.

flow_api_profile_inline.c (5262)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> There might be
dereferencing of a potential null pointer 'fh'. Check lines: 5262, 5260.

flow_api_profile_inline.c (4307)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'err' is
always false.

flow_api_profile_inline.c (2040)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always true: match_cnt =3D=3D 1.

flow_api_profile_inline.c (196)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer is cast
to a more strictly aligned pointer type

flow_api_profile_inline.c (254)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer is cast
to a more strictly aligned pointer type

flow_api_profile_inline.c (294)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer is cast
to a more strictly aligned pointer type

flow_api_profile_inline.c (347)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer is cast
to a more strictly aligned pointer type

flow_api_profile_inline.c (434)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer 'data'
is cast to a more strictly aligned pointer type.

flow_api_profile_inline.c (510)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer 'data'
is cast to a more strictly aligned pointer type.

flow_api_profile_inline.c (980)
V1032 <https://pvs-studio.com/en/docs/warnings/v1032/> The pointer is cast
to a more strictly aligned pointer type

flow_api_profile_inline.c (4758)
V523 <https://pvs-studio.com/en/docs/warnings/v523/> The 'then' statement
is equivalent to the 'else' statement.

flow_api_profile_inline.c (2272)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items 'qw_data', 'qw_data', 'qw_mask'
in lines 2272, 2273, 2275.

flow_api_profile_inline.c (1160)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the eighth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

flow_api_profile_inline.c (1224)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

flow_api_profile_inline.c (3133)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

flow_api_profile_inline.c (4507)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

flow_api_profile_inline.c (3573)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'action_set_data.contains_jump' variable was assigned the same value.

flow_api_profile_inline.c (972)
V1051 <https://pvs-studio.com/en/docs/warnings/v1051/> Consider checking
for misprints. It's possible that the 'flm_id' should be checked here.

flow_nthw_cat.c (29)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_csu.c (33)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_flm.c (30)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_flm.c (736)
V1020 <https://pvs-studio.com/en/docs/warnings/v1020/> The function exited
without calling the 'rte_spinlock_unlock' function. Check lines: 736, 729.

flow_nthw_hfu.c (33)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_hsh.c (34)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_info.c (34)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_km.c (43)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_pdb.c (34)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_qsl.c (34)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_rpp_lr.c (33)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_rpp_lr.c (65)
V1004 <https://pvs-studio.com/en/docs/warnings/v1004/> The 'p->m_rpp_lr'
pointer was used unsafely after it was verified against nullptr. Check
lines: 57, 65.

flow_nthw_slc_lr.c (34)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_tx_cpy.c (34)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_tx_ins.c (33)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

flow_nthw_tx_rpl.c (33)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_fpga_model.c (491)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'p->m_rpp_lr'
pointer was utilized before it was verified against nullptr. Check lines:
'nthw_fpga_model.c:479', 'nthw_fpga_model.c:491', 'flow_nthw_rpp_lr.c:65',
'flow_nthw_rpp_lr.c:69'.

nthw_fpga_model.c (186)
V597 <https://pvs-studio.com/en/docs/warnings/v597/> The compiler could
delete the 'memset' function call, which is used to flush 'p' object. The
memset_s() function should be used to erase the private data.

nthw_fpga_model.c (365)
V522 <https://pvs-studio.com/en/docs/warnings/v522/> Dereferencing of the
null pointer might take place. The potential null pointer is passed into
'nthw_fpga_get_param_info' function. Inspect the second argument. Check
lines: 'nthw_fpga_model.c:365', 'nthw_fpga.c:25', 'nthw_fpga.c:687'.

nthw_fpga_model.c (906)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the 14th actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_fpga_model.c (906)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (515)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression '(word_cnt
+ 3) > (0x4000)' is always false.

nthw_rac.c (34)
V575 <https://pvs-studio.com/en/docs/warnings/v575/> The potential null
pointer is passed into 'memset' function. Inspect the first argument. Check
lines: 34, 33.

nthw_rac.c (265)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the eighth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (469)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the eighth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (508)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the eighth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (560)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (578)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (747)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (768)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

nthw_rac.c (94)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'p->mp_reg_dbg_data' variable was assigned the same value.

ntnic_meter.c (89)
V525 <https://pvs-studio.com/en/docs/warnings/v525/> The code contains the
collection of similar blocks. Check items '0', '1', '0', '0', '0', '0' in
lines 89, 90, 91, 94, 95, 96.

nthw_stat.c (257)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'p->mn_stat_layout_version' variable was assigned the same value.

ntnic_ethdev.c (2194)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'err =3D=3D=
 0'
is always true.

ntnic_ethdev.c (334)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'internals->p_drv'
pointer was utilized before it was verified against nullptr. Check lines:
334, 350.

ntnic_ethdev.c (2268)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression '(1 <<
n_intf_no) & ~n_port_mask' is always false.

ntnic_ethdev.c (191)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: !p_nt4ga_stat.

ntnic_ethdev.c (238)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: !p_nt4ga_stat.

ntnic_ethdev.c (1763)
V1044 <https://pvs-studio.com/en/docs/warnings/v1044/> Loop break
conditions do not depend on the number of iterations.

ntnic_ethdev.c (1900)
V1044 <https://pvs-studio.com/en/docs/warnings/v1044/> Loop break
conditions do not depend on the number of iterations.

ntnic_ethdev.c (1935)
V1044 <https://pvs-studio.com/en/docs/warnings/v1044/> Loop break
conditions do not depend on the number of iterations.

ntnic_ethdev.c (1942)
V1044 <https://pvs-studio.com/en/docs/warnings/v1044/> Loop break
conditions do not depend on the number of iterations.

ntnic_ethdev.c (1370)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'port =3D=
=3D
internals->n_intf_no' is always true.

ntnic_ethdev.c (1396)
V547 <https://pvs-studio.com/en/docs/warnings/v547/> Expression 'port =3D=
=3D
internals->n_intf_no' is always true.

ntnic_ethdev.c (375)
V574 <https://pvs-studio.com/en/docs/warnings/v574/> The 'hw_recv' pointer
is used simultaneously as an array and as a pointer to single object. Check
lines: 375, 457.

ntnic_ethdev.c (844)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (866)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the tenth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (907)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (974)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the seventh actual argument of the 'rte_log' function.
The UNSIGNED integer type argument is expected.

ntnic_ethdev.c (974)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

ntnic_ethdev.c (1012)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (1042)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (1076)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (1136)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (1277)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

ntnic_ethdev.c (1335)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

ntnic_ethdev.c (2302)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_ethdev.c (2308)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the sixth actual argument of the 'rte_log' function. The
SIGNED integer type argument is expected.

ntnic_filter.c (481)
V595 <https://pvs-studio.com/en/docs/warnings/v595/> The 'internals'
pointer was utilized before it was verified against nullptr. Check lines:
481, 487.

ntnic_filter.c (1159)
V560 <https://pvs-studio.com/en/docs/warnings/v560/> A part of conditional
expression is always false: !p_nt4ga_stat.

ntnic_filter.c (357)
V576 <https://pvs-studio.com/en/docs/warnings/v576/> Incorrect format.
Consider checking the fifth actual argument of the 'rte_log' function. The
UNSIGNED integer type argument is expected.

ntnic_filter.c (1121)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'flow_handle' class is cast to unrelated 'rte_flow' class.

ntnic_filter.c (1143)
V1027 <https://pvs-studio.com/en/docs/warnings/v1027/> Pointer to an object
of the 'rte_flow' class is cast to unrelated 'flow_handle' class.

ntnic_vfio.c (81)
V1048 <https://pvs-studio.com/en/docs/warnings/v1048/> The
'vfio->container_fd' variable was assigned the same value.

On Thu, Feb 20, 2025 at 2:04=E2=80=AFPM Serhii Iliushyk <sil-plv@napatech.c=
om>
wrote:

> This patchset adds support for the new adapter NT400D13.
>
> Danylo Vodopianov (23):
>   net/ntnic: add link agx 100g
>   net/ntnic: add link state machine
>   net/ntnic: add rpf and gfg init
>   net/ntnic: add agx setup for port
>   net/ntnic: add host loopback init
>   net/ntnic: add line loopback init
>   net/ntnic: add 100 gbps port init
>   net/ntnic: add port post init
>   net/ntnic: add nim low power API
>   net/ntnic: add link handling API
>   net/ntnic: add port init to the state machine
>   net/ntnic: add port disable API
>   net/ntnic: add nt400d13 pcm init
>   net/ntnic: add HIF clock test
>   net/ntnic: add nt400d13 PRM module init
>   net/ntnic: add nt400d13 PRM module reset
>   net/ntnic: add SPI v3 support for FPGA
>   net/ntnic: add i2cm init
>   net/ntnic: add pca init
>   net/ntnic: add pcal init
>   net/ntnic: add reset PHY init
>   net/ntnic: add igam module init
>   net/ntnic: init IGAM and config PLL for FPGA
>
> Serhii Iliushyk (9):
>   net/ntnic: add minimal initialization new NIC NT400D13
>   net/ntnic: add minimal reset FPGA
>   net/ntnic: add FPGA modules and registers
>   net/ntnic: add setup for fpga reset
>   net/ntnic: add default reset setting for NT400D13
>   net/ntnic: add DDR calibration to reset stage
>   net/ntnic: add PHY ftile reset
>   net/ntnic: add clock init
>   net/ntnic: revert untrusted loop bound
>
>  doc/guides/nics/ntnic.rst                     |    7 +-
>  doc/guides/rel_notes/release_25_03.rst        |    4 +
>  drivers/net/ntnic/adapter/nt4ga_adapter.c     |    9 +
>  drivers/net/ntnic/include/nt4ga_link.h        |    7 +
>  drivers/net/ntnic/include/nthw_gfg.h          |   33 +
>  drivers/net/ntnic/include/ntnic_nim.h         |    5 +
>  .../include/ntnic_nthw_fpga_rst_nt400dxx.h    |   34 +
>  .../link_agx_100g/nt4ga_agx_link_100g.c       | 1029 ++++++
>  drivers/net/ntnic/meson.build                 |   16 +
>  drivers/net/ntnic/nim/i2c_nim.c               |  158 +-
>  drivers/net/ntnic/nim/i2c_nim.h               |    6 +
>  ...00D13_U62_Si5332-GM2-RevD-1_V5-Registers.h |  425 +++
>  .../net/ntnic/nthw/core/include/nthw_fpga.h   |   10 +
>  .../net/ntnic/nthw/core/include/nthw_gmf.h    |    2 +
>  .../net/ntnic/nthw/core/include/nthw_hif.h    |    4 +
>  .../net/ntnic/nthw/core/include/nthw_i2cm.h   |    3 +
>  .../net/ntnic/nthw/core/include/nthw_igam.h   |   40 +
>  .../ntnic/nthw/core/include/nthw_pca9532.h    |   25 +
>  .../ntnic/nthw/core/include/nthw_pcal6416a.h  |   33 +
>  .../nthw/core/include/nthw_pcm_nt400dxx.h     |   40 +
>  .../ntnic/nthw/core/include/nthw_phy_tile.h   |  156 +
>  .../nthw/core/include/nthw_prm_nt400dxx.h     |   32 +
>  .../nthw/core/include/nthw_si5332_si5156.h    |   63 +
>  .../net/ntnic/nthw/core/include/nthw_spi_v3.h |  107 +
>  .../net/ntnic/nthw/core/include/nthw_spim.h   |   58 +
>  .../net/ntnic/nthw/core/include/nthw_spis.h   |   63 +
>  .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  220 ++
>  .../core/nt400dxx/reset/nthw_fpga_rst9574.c   |  377 ++
>  .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  427 +++
>  drivers/net/ntnic/nthw/core/nthw_fpga.c       |  464 +++
>  drivers/net/ntnic/nthw/core/nthw_gfg.c        |  340 ++
>  drivers/net/ntnic/nthw/core/nthw_gmf.c        |   41 +
>  drivers/net/ntnic/nthw/core/nthw_hif.c        |   92 +
>  drivers/net/ntnic/nthw/core/nthw_i2cm.c       |  139 +
>  drivers/net/ntnic/nthw/core/nthw_igam.c       |   93 +
>  drivers/net/ntnic/nthw/core/nthw_pca9532.c    |   60 +
>  drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |  103 +
>  .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |   80 +
>  drivers/net/ntnic/nthw/core/nthw_phy_tile.c   | 1242 +++++++
>  .../net/ntnic/nthw/core/nthw_prm_nt400dxx.c   |   55 +
>  .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  142 +
>  drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |  358 ++
>  drivers/net/ntnic/nthw/core/nthw_spim.c       |  113 +
>  drivers/net/ntnic/nthw/core/nthw_spis.c       |  121 +
>  drivers/net/ntnic/nthw/nthw_drv.h             |   31 +
>  drivers/net/ntnic/nthw/nthw_platform.c        |    3 +
>  drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +
>  .../supported/nthw_fpga_9574_055_049_0000.c   | 3124 +++++++++++++++++
>  .../nthw/supported/nthw_fpga_instances.c      |    5 +-
>  .../nthw/supported/nthw_fpga_instances.h      |    1 +
>  .../ntnic/nthw/supported/nthw_fpga_mod_defs.h |   11 +
>  .../nthw/supported/nthw_fpga_mod_str_map.c    |   11 +
>  .../ntnic/nthw/supported/nthw_fpga_reg_defs.h |   11 +
>  .../nthw/supported/nthw_fpga_reg_defs_igam.h  |   32 +
>  .../supported/nthw_fpga_reg_defs_pci_ta.h     |   33 +
>  .../nthw_fpga_reg_defs_pcm_nt400dxx.h         |   29 +
>  .../nthw/supported/nthw_fpga_reg_defs_pdi.h   |   49 +
>  .../supported/nthw_fpga_reg_defs_phy_tile.h   |  213 ++
>  .../nthw_fpga_reg_defs_prm_nt400dxx.h         |   26 +
>  .../nthw/supported/nthw_fpga_reg_defs_rfd.h   |   38 +
>  .../supported/nthw_fpga_reg_defs_rst9574.h    |   35 +
>  .../nthw/supported/nthw_fpga_reg_defs_spim.h  |   76 +
>  .../nthw/supported/nthw_fpga_reg_defs_spis.h  |   51 +
>  .../nthw/supported/nthw_fpga_reg_defs_tint.h  |   28 +
>  drivers/net/ntnic/ntnic_ethdev.c              |    1 +
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c |    2 +-
>  drivers/net/ntnic/ntnic_mod_reg.c             |   47 +
>  drivers/net/ntnic/ntnic_mod_reg.h             |   25 +
>  68 files changed, 10709 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/net/ntnic/include/nthw_gfg.h
>  create mode 100644
> drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
>  create mode 100644
> drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
>  create mode 100644
> drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Reg=
isters.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_igam.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx=
.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_phy_tile.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx=
.h
>  create mode 100644
> drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spim.h
>  create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spis.h
>  create mode 100644
> drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
>  create mode 100644
> drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
>  create mode 100644
> drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_gfg.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_igam.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_pca9532.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_phy_tile.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_spi_v3.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_spim.c
>  create mode 100644 drivers/net/ntnic/nthw/core/nthw_spis.c
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_9574_055_049_0000.c
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_igam.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pci_ta.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pcm_nt400dxx.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_pdi.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_phy_tile.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_prm_nt400dxx.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rfd.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9574.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spim.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_spis.h
>  create mode 100644
> drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_tint.h
>
> --
> 2.45.0
>
>

--000000000000c2332c062e9b87fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif;font-size:small">Ok, scan of ntnic with PVS studi=
o after this bundle.</div><div class=3D"gmail_default" style=3D"font-family=
:arial,sans-serif;font-size:small">Similar to Coverity it is a good automat=
ed tool for finding bugs.</div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,sans-serif;font-size:small"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,sans-serif;font-size:small"><table style=3D"=
color:rgb(0,0,0);font-variant-numeric:normal;font-variant-east-asian:normal=
;font-variant-alternates:normal;font-size-adjust:none;font-kerning:auto;fon=
t-feature-settings:normal;font-stretch:normal;font-size:12pt;line-height:no=
rmal;font-family:&quot;normal Century Gothic&quot;;width:1693px"><caption s=
tyle=3D"font-weight:bold;background-image:initial;background-position:initi=
al;background-size:initial;background-repeat:initial;background-origin:init=
ial;background-clip:initial;border:none">MESSAGES</caption><tbody><tr style=
=3D"background:black;color:white"><th style=3D"width:503.5px">Location</th>=
<th style=3D"width:82.25px">Code</th><th style=3D"width:1093.25px">Message<=
/th></tr><tr style=3D"background:lightcyan"><td colspan=3D"5" style=3D"padd=
ing:0px;text-align:center;vertical-align:top;color:red;font-size:1.2em">Fai=
ls/Info</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/adapter=
/nt4ga_adapter.c">nt4ga_adapter.c (129)</div></td><td style=3D"padding:0px;=
vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1095.25px">Incorrect format. Consider checking the s=
ixth actual argument of the &#39;rte_log&#39; function. Under certain condi=
tions the pointer can be null.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/dr=
ivers/net/ntnic/adapter/nt4ga_adapter.c">nt4ga_adapter.c (150)</div></td><t=
d style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blan=
k" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td =
style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. =
Consider checking the sixth actual argument of the &#39;rte_log&#39; functi=
on. Under certain conditions the pointer can be null.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c">nt4=
ga_stat.c (252)</div></td><td style=3D"padding:0px;vertical-align:top;width=
:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warni=
ngs/v595/">V595</a></td><td style=3D"padding:0px;vertical-align:top;width:1=
095.25px">The &#39;p_nt4ga_stat&#39; pointer was utilized before it was ver=
ified against nullptr. Check lines: 252, 259.</td></tr><tr><td style=3D"pad=
ding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/D=
PDK/nt400d13/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c">nt4ga_stat.=
c (47)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"=
><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/=
">V547</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px"=
>Expression &#39;p_nt4ga_stat&#39; is always true.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c">ntnic_db=
sconfig.c (595)</div></td><td style=3D"padding:0px;vertical-align:top;width=
:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warni=
ngs/v595/">V595</a></td><td style=3D"padding:0px;vertical-align:top;width:1=
095.25px">The &#39;txvq&#39; pointer was utilized before it was verified ag=
ainst nullptr. Check lines: 595, 597.</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt40=
0d13/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c">ntnic_dbsconfig.c (765)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a ta=
rget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Expre=
ssion &#39;irq_vector &gt;=3D 0&#39; is always false.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c">ntnic_d=
bsconfig.c (400)</div></td><td style=3D"padding:0px;vertical-align:top;widt=
h:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warn=
ings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:=
1095.25px">Incorrect format. Consider checking the sixth actual argument of=
 the &#39;rte_log&#39; function. The UNSIGNED integer type argument is expe=
cted.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5p=
x"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/include/h=
w_mod_backend.h">hw_mod_backend.h (750)</div></td><td style=3D"padding:0px;=
vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v1071/">V1071</a></td><td style=3D"padding:0px;=
vertical-align:top;width:1095.25px">Consider inspecting the &#39;hw_mod_hsh=
_rcp_set&#39; function. The return value is not always used. Total calls: 1=
5, discarded results: 1.</td></tr><tr><td style=3D"padding:0px;vertical-ali=
gn:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/=
net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c">nt4ga_link_100g.c (259)</d=
iv></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a targe=
t=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v781/">V781</a=
></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The valu=
e of the &#39;port&#39; variable is checked after it was used. Perhaps ther=
e is a mistake in program logic. Check lines: 259, 261.</td></tr><tr><td st=
yle=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/sh=
emminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100=
g.c">nt4ga_link_100g.c (674)</div></td><td style=3D"padding:0px;vertical-al=
ign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/=
en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0px;vertical-alig=
n:top;width:1095.25px">A part of conditional expression is always true: res=
 =3D=3D 0.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:5=
05.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/link=
_mgmt/link_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100g.c (696)</div=
></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v523/">V523</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The &#39;=
then&#39; statement is equivalent to the &#39;else&#39; statement.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_agx_100=
g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100g.c (1012)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Expression &#39;res =3D=
=3D 0&#39; is always true.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driver=
s/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_1=
00g.c (1021)</div></td><td style=3D"padding:0px;vertical-align:top;width:84=
.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings=
/v547/">V547</a></td><td style=3D"padding:0px;vertical-align:top;width:1095=
.25px">Expression &#39;res =3D=3D 0&#39; is always true.</td></tr><tr><td s=
tyle=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/s=
hemminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx=
_link_100g.c">nt4ga_agx_link_100g.c (522)</div></td><td style=3D"padding:0p=
x;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pv=
s-studio.com/en/docs/warnings/v781/">V781</a></td><td style=3D"padding:0px;=
vertical-align:top;width:1095.25px">The value of the &#39;port&#39; variabl=
e is checked after it was used. Perhaps there is a mistake in program logic=
. Check lines: 522, 524.</td></tr><tr><td style=3D"padding:0px;vertical-ali=
gn:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/=
net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100=
g.c (916)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25=
px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v6=
19/">V619</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25=
px">The array &#39;nim_ctx&#39; is being utilized as a pointer to single ob=
ject.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5p=
x"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt=
/link_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100g.c (318)</div></td=
><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_b=
lank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><=
td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect forma=
t. Consider checking the fifth actual argument of the &#39;rte_log&#39; fun=
ction. The UNSIGNED integer type argument is expected.</td></tr><tr><td sty=
le=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/she=
mminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_l=
ink_100g.c">nt4ga_agx_link_100g.c (370)</div></td><td style=3D"padding:0px;=
vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1095.25px">Incorrect format. Consider checking the s=
eventh actual argument of the &#39;rte_log&#39; function. The SIGNED intege=
r type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical=
-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driv=
ers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link=
_100g.c (370)</div></td><td style=3D"padding:0px;vertical-align:top;width:8=
4.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:109=
5.25px">Incorrect format. Consider checking the sixth actual argument of th=
e &#39;rte_log&#39; function. The SIGNED integer type argument is expected.=
</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><d=
iv title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link=
_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100g.c (385)</div></td><td =
style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank"=
 href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td st=
yle=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Co=
nsider checking the fifth actual argument of the &#39;rte_log&#39; function=
. The UNSIGNED integer type argument is expected.</td></tr><tr><td style=3D=
"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemming=
er/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_1=
00g.c">nt4ga_agx_link_100g.c (391)</div></td><td style=3D"padding:0px;verti=
cal-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studi=
o.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertica=
l-align:top;width:1095.25px">Incorrect format. Consider checking the fifth =
actual argument of the &#39;rte_log&#39; function. The UNSIGNED integer typ=
e argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/n=
et/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100g=
.c (976)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Incorrect format. Consider checking the sixth actual argument of the &#3=
9;rte_log&#39; function. The UNSIGNED integer type argument is expected.</t=
d></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div =
title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_ag=
x_100g/nt4ga_agx_link_100g.c">nt4ga_agx_link_100g.c (984)</div></td><td sty=
le=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the sixth actual argument of the &#39;rte_log&#39; function. T=
he UNSIGNED integer type argument is expected.</td></tr><tr><td style=3D"pa=
dding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/=
DPDK/nt400d13/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g=
.c">nt4ga_agx_link_100g.c (380)</div></td><td style=3D"padding:0px;vertical=
-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.c=
om/en/docs/warnings/v1051/">V1051</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1095.25px">Consider checking for misprints. It&#39;s possi=
ble that the &#39;state-&gt;link_up&#39; should be checked here.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D=
"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nim/i2c_nim.c">i2c_nim.c =
(126)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/"=
>V547</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">=
Expression &#39;multi_byte =3D=3D 1&#39; is always true.</td></tr><tr><td s=
tyle=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/s=
hemminger/DPDK/nt400d13/drivers/net/ntnic/nim/i2c_nim.c">i2c_nim.c (881)</d=
iv></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a targe=
t=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519</a=
></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The vari=
able is assigned values twice successively. Perhaps this is a mistake. Chec=
k lines: 880, 881.</td></tr><tr><td style=3D"padding:0px;vertical-align:top=
;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/nt=
nic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c">nthw_fpga_rst9563.c (62)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The &#=
39;p-&gt;mp_fld_rst_ptp&#39; variable is assigned values twice successively=
. Perhaps this is a mistake. Check lines: 61, 62.</td></tr><tr><td style=3D=
"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemming=
er/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst95=
63.c">nthw_fpga_rst9563.c (107)</div></td><td style=3D"padding:0px;vertical=
-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.c=
om/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:0px;vertical-a=
lign:top;width:1095.25px">Expression &#39;!p-&gt;mp_fld_stat_tsm_ref_mmcm_l=
ocked&#39; is always true.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driver=
s/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c">nthw_fpga_rst9563=
.c (129)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v54=
7/">V547</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Expression &#39;!p-&gt;mp_fld_sticky_tsm_ref_mmcm_unlocked&#39; is alway=
s true.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/co=
re/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c">nthw_fpga_rst_nt200a0x.c (531)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v519/">V519<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The &#=
39;res&#39; variable is assigned values twice successively. Perhaps this is=
 a mistake. Check lines: 530, 531.</td></tr><tr><td style=3D"padding:0px;ve=
rtical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d1=
3/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c">nthw=
_fpga_rst_nt200a0x.c (62)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1095.25px">Incorrect format. Consider checking the sixth actual ar=
gument of the &#39;rte_log&#39; function. The SIGNED integer type argument =
is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width=
:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nt=
hw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c">nthw_fpga_rst_nt200a0x.c (=
72)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a=
 target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V=
576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">In=
correct format. Consider checking the sixth actual argument of the &#39;rte=
_log&#39; function. The SIGNED integer type argument is expected.</td></tr>=
<tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nt400dxx/nth=
w_fpga_nt400dxx.c">nthw_fpga_nt400dxx.c (187)</div></td><td style=3D"paddin=
g:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https:=
//pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:=
0px;vertical-align:top;width:1095.25px">Expression &#39;rst9574_ops&#39; is=
 always true.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;widt=
h:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/n=
thw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c">nthw_fpga_rst_nt400dxx.c =
(185)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v595/"=
>V595</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">=
The &#39;p_fpga_info&#39; pointer was utilized before it was verified again=
st nullptr. Check lines: 185, 194.</td></tr><tr><td style=3D"padding:0px;ve=
rtical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d1=
3/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c">nthw=
_fpga_rst_nt400dxx.c (60)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v525/">V525</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1095.25px">The code contains the collection of similar blocks. Che=
ck items &#39;nthw_prm_nt400dxx_platform_rst&#39;, &#39;nthw_prm_nt400dxx_p=
eriph_rst&#39;, &#39;nthw_prm_nt400dxx_periph_rst&#39; in lines 60, 64, 66.=
</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><d=
iv title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nt40=
0dxx/reset/nthw_fpga_rst_nt400dxx.c">nthw_fpga_rst_nt400dxx.c (116)</div></=
td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"=
_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v525/">V525</a></td=
><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The code cont=
ains the collection of similar blocks. Check items &#39;0&#39;, &#39;1&#39;=
, &#39;0&#39;, &#39;0&#39;, &#39;1&#39; in lines 116, 122, 128, 134, 140.</=
td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div=
 title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_f=
pga.c">nthw_fpga.c (623)</div></td><td style=3D"padding:0px;vertical-align:=
top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/d=
ocs/warnings/v595/">V595</a></td><td style=3D"padding:0px;vertical-align:to=
p;width:1095.25px">The &#39;p_fpga_info&#39; pointer was utilized before it=
 was verified against nullptr. Check lines: 623, 639.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_fpga.c">nthw_fpga.c (=
317)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><=
a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v560/">=
V560</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">A=
 part of conditional expression is always false: avr_vpd_info.n_avr_spi_ver=
sion &gt;=3D 3.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wi=
dth:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic=
/nthw/core/nthw_fpga.c">nthw_fpga.c (387)</div></td><td style=3D"padding:0p=
x;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pv=
s-studio.com/en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0px;=
vertical-align:top;width:1095.25px">A part of conditional expression is alw=
ays false: avr_vpd_info.n_avr_spi_version &gt;=3D 3.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_fpga.c">nthw_fpga.c (4=
69)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a=
 target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v560/">V=
560</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">A =
part of conditional expression is always false: avr_vpd_info.n_avr_spi_vers=
ion &gt;=3D 3.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/=
nthw/core/nthw_fpga.c">nthw_fpga.c (831)</div></td><td style=3D"padding:0px=
;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs=
-studio.com/en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0px;v=
ertical-align:top;width:1095.25px">A part of conditional expression is alwa=
ys true: p_fpga_info.</td></tr><tr><td style=3D"padding:0px;vertical-align:=
top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net=
/ntnic/nthw/core/nthw_fpga.c">nthw_fpga.c (831)</div></td><td style=3D"padd=
ing:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"http=
s://pvs-studio.com/en/docs/warnings/v571/">V571</a></td><td style=3D"paddin=
g:0px;vertical-align:top;width:1095.25px">Recurring check. The &#39;p_fpga_=
info&#39; condition was already verified in line 830.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_fpga.c">nthw_fpga.c (=
524)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><=
a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1086/"=
>V1086</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px"=
>A call of the &#39;memcpy&#39; function will lead to underflow of the buff=
er &#39;&amp; p_vpd_board_info[0]&#39;.</td></tr><tr><td style=3D"padding:0=
px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt=
400d13/drivers/net/ntnic/nthw/core/nthw_hif.c">nthw_hif.c (27)</div></td><t=
d style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blan=
k" href=3D"https://pvs-studio.com/en/docs/warnings/v597/">V597</a></td><td =
style=3D"padding:0px;vertical-align:top;width:1095.25px">The compiler could=
 delete the &#39;memset&#39; function call, which is used to flush &#39;p&#=
39; object. The memset_s() function should be used to erase the private dat=
a.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px">=
<div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nt=
hw_hif.c">nthw_hif.c (82)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1095.25px">Incorrect format. Consider checking the seventh actual =
argument of the &#39;rte_log&#39; function. The SIGNED integer type argumen=
t is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/=
nthw/core/nthw_iic.c">nthw_iic.c (257)</div></td><td style=3D"padding:0px;v=
ertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1095.25px">The compiler could delete the &#39;memset&=
#39; function call, which is used to flush &#39;p&#39; object. The memset_s=
() function should be used to erase the private data.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_iic.c">nthw_iic.c (24=
2)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Inc=
orrect format. Consider checking the seventh actual argument of the &#39;rt=
e_log&#39; function. The SIGNED integer type argument is expected.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_pcie3.c=
">nthw_pcie3.c (28)</div></td><td style=3D"padding:0px;vertical-align:top;w=
idth:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/w=
arnings/v597/">V597</a></td><td style=3D"padding:0px;vertical-align:top;wid=
th:1095.25px">The compiler could delete the &#39;memset&#39; function call,=
 which is used to flush &#39;p&#39; object. The memset_s() function should =
be used to erase the private data.</td></tr><tr><td style=3D"padding:0px;ve=
rtical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d1=
3/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c">nthw_pcm_nt400dxx.c (45)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a ta=
rget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v525/">V525=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The c=
ode contains the collection of similar blocks. Check items &#39;nthw_regist=
er_query_field&#39;, &#39;nthw_register_get_field&#39;, &#39;nthw_register_=
get_field&#39; in lines 45, 49, 53.</td></tr><tr><td style=3D"padding:0px;v=
ertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d=
13/drivers/net/ntnic/nthw/core/nthw_phy_tile.c">nthw_phy_tile.c (821)</div>=
</td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Expressio=
n &#39;i =3D=3D 0&#39; is always false.</td></tr><tr><td style=3D"padding:0=
px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt=
400d13/drivers/net/ntnic/nthw/core/nthw_phy_tile.c">nthw_phy_tile.c (800)</=
div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a targ=
et=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1048/">V1048=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The &=
#39;xcvr_instance&#39; variable was assigned the same value.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/ho=
me/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_phy_tile.c">nt=
hw_phy_tile.c (86)</div></td><td style=3D"padding:0px;vertical-align:top;wi=
dth:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/wa=
rnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;widt=
h:1095.25px">Incorrect format. Consider checking the fifth actual argument =
of the &#39;rte_log&#39; function. The UNSIGNED integer type argument is ex=
pected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/co=
re/nthw_rpf.c">nthw_rpf.c (26)</div></td><td style=3D"padding:0px;vertical-=
align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.co=
m/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;vertical-al=
ign:top;width:1095.25px">The compiler could delete the &#39;memset&#39; fun=
ction call, which is used to flush &#39;p&#39; object. The memset_s() funct=
ion should be used to erase the private data.</td></tr><tr><td style=3D"pad=
ding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/D=
PDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_sdc.c">nthw_sdc.c (26)</div><=
/td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D=
"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v597/">V597</a></t=
d><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The compiler=
 could delete the &#39;memset&#39; function call, which is used to flush &#=
39;p&#39; object. The memset_s() function should be used to erase the priva=
te data.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505=
.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/c=
ore/nthw_sdc.c">nthw_sdc.c (135)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1095.25px">Expression &#39;pn_result_mask&#39; is always tr=
ue.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"=
><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/n=
thw_si5340.c">nthw_si5340.c (48)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1095.25px">The compiler could delete the &#39;memset&#39; f=
unction call, which is used to flush &#39;p&#39; object. The memset_s() fun=
ction should be used to erase the private data.</td></tr><tr><td style=3D"p=
adding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger=
/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_spi_v3.c">nthw_spi_v3.c (14=
0)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Inc=
orrect format. Consider checking the sixth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D=
"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/core/nthw_spi_v3.c">=
nthw_spi_v3.c (148)</div></td><td style=3D"padding:0px;vertical-align:top;w=
idth:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/w=
arnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;wid=
th:1095.25px">Incorrect format. Consider checking the sixth actual argument=
 of the &#39;rte_log&#39; function. The SIGNED integer type argument is exp=
ected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5=
px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/cor=
e/nthw_spi_v3.c">nthw_spi_v3.c (154)</div></td><td style=3D"padding:0px;ver=
tical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-stu=
dio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;verti=
cal-align:top;width:1095.25px">Incorrect format. Consider checking the sixt=
h actual argument of the &#39;rte_log&#39; function. The SIGNED integer typ=
e argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/n=
et/ntnic/nthw/core/nthw_spi_v3.c">nthw_spi_v3.c (159)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the sixth actual argument of the &#39;rte_log&#39; function. T=
he SIGNED integer type argument is expected.</td></tr><tr><td style=3D"padd=
ing:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DP=
DK/nt400d13/drivers/net/ntnic/nthw/core/nthw_tsm.c">nthw_tsm.c (92)</div></=
td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"=
_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td=
><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Expression &#=
39;p_ts&#39; is always true.</td></tr><tr><td style=3D"padding:0px;vertical=
-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driv=
ers/net/ntnic/nthw/core/nthw_tsm.c">nthw_tsm.c (111)</div></td><td style=3D=
"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D=
"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"p=
adding:0px;vertical-align:top;width:1095.25px">Expression &#39;p_time&#39; =
is always true.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wi=
dth:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic=
/nthw/flow_api/flow_api.c">flow_api.c (833)</div></td><td style=3D"padding:=
0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://=
pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:0p=
x;vertical-align:top;width:1095.25px">Expression &#39;ndev&#39; is always t=
rue.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px=
"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_=
api/flow_api.c">flow_api.c (999)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v1029/">V1029</a></td><td style=3D"padding:0px;vertica=
l-align:top;width:1095.25px">Numeric Truncation Error. Return value of the =
&#39;strlen&#39; function is written to the 16-bit variable.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/ho=
me/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_api.c">flo=
w_api.c (1001)</div></td><td style=3D"padding:0px;vertical-align:top;width:=
84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnin=
gs/v1029/">V1029</a></td><td style=3D"padding:0px;vertical-align:top;width:=
1095.25px">Numeric Truncation Error. Return value of the &#39;strlen&#39; f=
unction is written to the 16-bit variable.</td></tr><tr><td style=3D"paddin=
g:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK=
/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_api.c">flow_api.c (214)</div=
></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect=
 format. Consider checking the seventh actual argument of the &#39;rte_log&=
#39; function. The SIGNED integer type argument is expected.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/ho=
me/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_api.c">flo=
w_api.c (227)</div></td><td style=3D"padding:0px;vertical-align:top;width:8=
4.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:109=
5.25px">Incorrect format. Consider checking the seventh actual argument of =
the &#39;rte_log&#39; function. The SIGNED integer type argument is expecte=
d.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px">=
<div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_ap=
i/flow_api.c">flow_api.c (428)</div></td><td style=3D"padding:0px;vertical-=
align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.co=
m/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-al=
ign:top;width:1095.25px">Incorrect format. Consider checking the fifth actu=
al argument of the &#39;rte_log&#39; function. The SIGNED integer type argu=
ment is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;=
width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntn=
ic/nthw/flow_api/flow_group.c">flow_group.c (35)</div></td><td style=3D"pad=
ding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v522/">V522</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1095.25px">There might be dereferencing of =
a potential null pointer &#39;group_handle&#39;. Check lines: 35, 32.</td><=
/tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div tit=
le=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_h=
sh_cfg.c">flow_hsh_cfg.c (74)</div></td><td style=3D"padding:0px;vertical-a=
lign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com=
/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:1095.25px">Incorrect format. Consider checking the seventh act=
ual argument of the &#39;rte_log&#39; function. The SIGNED integer type arg=
ument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top=
;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/nt=
nic/nthw/flow_api/flow_hsh_cfg.c">flow_hsh_cfg.c (77)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the seventh actual argument of the &#39;rte_log&#39; function.=
 The SIGNED integer type argument is expected.</td></tr><tr><td style=3D"pa=
dding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/=
DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_id_table.c">flow_id_tabl=
e.c (71)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v52=
2/">V522</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">There might be dereferencing of a potential null pointer &#39;handle&#39=
;. Check lines: 71, 69.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/n=
et/ntnic/nthw/flow_api/flow_km.c">flow_km.c (583)</div></td><td style=3D"pa=
dding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"ht=
tps://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padd=
ing:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider chec=
king the seventh actual argument of the &#39;rte_log&#39; function. The SIG=
NED integer type argument is expected.</td></tr><tr><td style=3D"padding:0p=
x;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt4=
00d13/drivers/net/ntnic/nthw/flow_api/flow_km.c">flow_km.c (614)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format=
. Consider checking the seventh actual argument of the &#39;rte_log&#39; fu=
nction. The SIGNED integer type argument is expected.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_km.c">flow_km.c (=
791)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><=
a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">=
V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">I=
ncorrect format. Consider checking the sixth actual argument of the &#39;rt=
e_log&#39; function. The SIGNED integer type argument is expected.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/flow_km.=
c">flow_km.c (92)</div></td><td style=3D"padding:0px;vertical-align:top;wid=
th:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/war=
nings/v769/">V769</a></td><td style=3D"padding:0px;vertical-align:top;width=
:1095.25px">The &#39;(char *) km-&gt;cam_dist&#39; pointer in the expressio=
n could be nullptr. In such case, resulting value of arithmetic operations =
on this pointer will be senseless and it should not be used. Check lines: 9=
2, 85.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5=
px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flo=
w_api/hw_mod/hw_mod_flm.c">hw_mod_flm.c (836)</div></td><td style=3D"paddin=
g:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https:=
//pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:=
0px;vertical-align:top;width:1095.25px">Expression &#39;be-&gt;flm.ver &lt;=
 18&#39; is always false.</td></tr><tr><td style=3D"padding:0px;vertical-al=
ign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers=
/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c">hw_mod_hsh.c (127)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v568/">V568</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1095.25px">It&#39;s odd tha=
t &#39;sizeof()&#39; operator evaluates the size of a pointer to a class, b=
ut not the size of the &#39;be-&gt;hsh.v5.rcp&#39; class object.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D=
"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_m=
od_hsh.c">hw_mod_hsh.c (130)</div></td><td style=3D"padding:0px;vertical-al=
ign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/=
en/docs/warnings/v1064/">V1064</a></td><td style=3D"padding:0px;vertical-al=
ign:top;width:1095.25px">The &#39;buffer_size&#39; operand of integer divis=
ion is less than the &#39;element_size&#39; one. The result will always be =
zero.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5p=
x"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow=
_api/hw_mod/hw_mod_hsh.c">hw_mod_hsh.c (133)</div></td><td style=3D"padding=
:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https:/=
/pvs-studio.com/en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0=
px;vertical-align:top;width:1095.25px">A part of conditional expression is =
always false: index &lt; max_idx. Unsigned type value is never &lt; 0.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/hw_mo=
d/hw_mod_hsh.c">hw_mod_hsh.c (133)</div></td><td style=3D"padding:0px;verti=
cal-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studi=
o.com/en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0px;vertica=
l-align:top;width:1095.25px">A part of conditional expression is always fal=
se: word_off &lt; max_idx. Unsigned type value is never &lt; 0.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"=
/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mo=
d_pdb.c">hw_mod_pdb.c (137)</div></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/e=
n/docs/warnings/v568/">V568</a></td><td style=3D"padding:0px;vertical-align=
:top;width:1095.25px">It&#39;s odd that &#39;sizeof()&#39; operator evaluat=
es the size of a pointer to a class, but not the size of the &#39;be-&gt;pd=
b.v9.rcp&#39; class object.</td></tr><tr><td style=3D"padding:0px;vertical-=
align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drive=
rs/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c">hw_mod_pdb.c (140)</div></t=
d><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_=
blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1064/">V1064</a></t=
d><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The &#39;buf=
fer_size&#39; operand of integer division is less than the &#39;element_siz=
e&#39; one. The result will always be zero.</td></tr><tr><td style=3D"paddi=
ng:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPD=
K/nt400d13/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c">hw_mod_pdb.=
c (143)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px=
"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v560=
/">V560</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px=
">A part of conditional expression is always false: * value &lt; max_idx. U=
nsigned type value is never &lt; 0.</td></tr><tr><td style=3D"padding:0px;v=
ertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d=
13/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c">hw_mod_pdb.c (143)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v560/">V560<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">A part=
 of conditional expression is always false: index &lt; max_idx. Unsigned ty=
pe value is never &lt; 0.</td></tr><tr><td style=3D"padding:0px;vertical-al=
ign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers=
/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c">flm_evt_queue.c (1=
94)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a=
 target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v557/">V=
557</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Ar=
ray overrun is possible. The value of &#39;port&#39; index could reach 127.=
</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><d=
iv title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/=
profile_inline/flm_evt_queue.c">flm_evt_queue.c (202)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v557/">V557</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Array overrun is possib=
le. The value of &#39;port&#39; index could reach 127.</td></tr><tr><td sty=
le=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/she=
mminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_ev=
t_queue.c">flm_evt_queue.c (80)</div></td><td style=3D"padding:0px;vertical=
-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.c=
om/en/docs/warnings/v1037/">V1037</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1095.25px">Two or more case-branches perform the same acti=
ons. Check lines: 80, 88</td></tr><tr><td style=3D"padding:0px;vertical-ali=
gn:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/=
net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c">flm_evt_queue.c (84=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1037/">V1=
037</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Tw=
o or more case-branches perform the same actions. Check lines: 84, 92</td><=
/tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div tit=
le=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profil=
e_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (2461)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v1086/">V1086</a></td>=
<td style=3D"padding:0px;vertical-align:top;width:1095.25px">A call of the =
&#39;memset&#39; function will lead to underflow of the buffer &#39;&amp; d=
b-&gt;flm[idx.id1].data&#39;.</td></tr><tr><td style=3D"padding:0px;vertica=
l-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/dri=
vers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_a=
pi_hw_db_inline.c (426)</div></td><td style=3D"padding:0px;vertical-align:t=
op;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/do=
cs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top=
;width:1095.25px">Incorrect format. Consider checking the third actual argu=
ment of the &#39;fprintf&#39; function. The SIGNED integer type argument is=
 expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:5=
05.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw=
/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (=
428)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><=
a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">=
V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">I=
ncorrect format. Consider checking the fifth actual argument of the &#39;fp=
rintf&#39; function. The SIGNED integer type argument is expected.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_=
inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (428)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. C=
onsider checking the fourth actual argument of the &#39;fprintf&#39; functi=
on. The SIGNED integer type argument is expected.</td></tr><tr><td style=3D=
"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemming=
er/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw=
_db_inline.c">flow_api_hw_db_inline.c (428)</div></td><td style=3D"padding:=
0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://=
pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0p=
x;vertical-align:top;width:1095.25px">Incorrect format. Consider checking t=
he sixth actual argument of the &#39;fprintf&#39; function. The SIGNED inte=
ger type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/dr=
ivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_=
api_hw_db_inline.c (428)</div></td><td style=3D"padding:0px;vertical-align:=
top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/d=
ocs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:to=
p;width:1095.25px">Incorrect format. Consider checking the third actual arg=
ument of the &#39;fprintf&#39; function. The SIGNED integer type argument i=
s expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:=
505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nth=
w/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c =
(438)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/"=
>V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">=
Incorrect format. Consider checking the third actual argument of the &#39;f=
printf&#39; function. The SIGNED integer type argument is expected.</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_=
inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (446)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. C=
onsider checking the third actual argument of the &#39;fprintf&#39; functio=
n. The SIGNED integer type argument is expected.</td></tr><tr><td style=3D"=
padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminge=
r/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_=
db_inline.c">flow_api_hw_db_inline.c (455)</div></td><td style=3D"padding:0=
px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://p=
vs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px=
;vertical-align:top;width:1095.25px">Incorrect format. Consider checking th=
e third actual argument of the &#39;fprintf&#39; function. The SIGNED integ=
er type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertica=
l-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/dri=
vers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_a=
pi_hw_db_inline.c (457)</div></td><td style=3D"padding:0px;vertical-align:t=
op;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/do=
cs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top=
;width:1095.25px">Incorrect format. Consider checking the eighth actual arg=
ument of the &#39;fprintf&#39; function. The SIGNED integer type argument i=
s expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:=
505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nth=
w/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c =
(457)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px">=
<a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/"=
>V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">=
Incorrect format. Consider checking the fifth actual argument of the &#39;f=
printf&#39; function. The SIGNED integer type argument is expected.</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_=
inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (457)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. C=
onsider checking the fourth actual argument of the &#39;fprintf&#39; functi=
on. The SIGNED integer type argument is expected.</td></tr><tr><td style=3D=
"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemming=
er/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw=
_db_inline.c">flow_api_hw_db_inline.c (457)</div></td><td style=3D"padding:=
0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://=
pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0p=
x;vertical-align:top;width:1095.25px">Incorrect format. Consider checking t=
he seventh actual argument of the &#39;fprintf&#39; function. The SIGNED in=
teger type argument is expected.</td></tr><tr><td style=3D"padding:0px;vert=
ical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/=
drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flo=
w_api_hw_db_inline.c (457)</div></td><td style=3D"padding:0px;vertical-alig=
n:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en=
/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:=
top;width:1095.25px">Incorrect format. Consider checking the sixth actual a=
rgument of the &#39;fprintf&#39; function. The SIGNED integer type argument=
 is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;widt=
h:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/n=
thw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.=
c (457)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px=
"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576=
/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px=
">Incorrect format. Consider checking the third actual argument of the &#39=
;fprintf&#39; function. The SIGNED integer type argument is expected.</td><=
/tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div tit=
le=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profil=
e_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (467)</div></td><=
td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bla=
nk" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td=
 style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format.=
 Consider checking the third actual argument of the &#39;fprintf&#39; funct=
ion. The SIGNED integer type argument is expected.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api=
_hw_db_inline.c">flow_api_hw_db_inline.c (482)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding=
:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider checkin=
g the third actual argument of the &#39;fprintf&#39; function. The SIGNED i=
nteger type argument is expected.</td></tr><tr><td style=3D"padding:0px;ver=
tical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13=
/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">fl=
ow_api_hw_db_inline.c (494)</div></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/e=
n/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align=
:top;width:1095.25px">Incorrect format. Consider checking the third actual =
argument of the &#39;fprintf&#39; function. The SIGNED integer type argumen=
t is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/=
nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline=
.c (509)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Incorrect format. Consider checking the third actual argument of the &#3=
9;fprintf&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profi=
le_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (518)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format=
. Consider checking the third actual argument of the &#39;fprintf&#39; func=
tion. The SIGNED integer type argument is expected.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api=
_hw_db_inline.c">flow_api_hw_db_inline.c (526)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding=
:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider checkin=
g the third actual argument of the &#39;fprintf&#39; function. The SIGNED i=
nteger type argument is expected.</td></tr><tr><td style=3D"padding:0px;ver=
tical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13=
/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">fl=
ow_api_hw_db_inline.c (560)</div></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/e=
n/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align=
:top;width:1095.25px">Incorrect format. Consider checking the third actual =
argument of the &#39;fprintf&#39; function. The SIGNED integer type argumen=
t is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/=
nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline=
.c (578)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Incorrect format. Consider checking the third actual argument of the &#3=
9;fprintf&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profi=
le_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (579)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format=
. Consider checking the fifth actual argument of the &#39;fprintf&#39; func=
tion. The integer argument of 32-bit size is expected.</td></tr><tr><td sty=
le=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/she=
mminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_a=
pi_hw_db_inline.c">flow_api_hw_db_inline.c (579)</div></td><td style=3D"pad=
ding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider check=
ing the fourth actual argument of the &#39;fprintf&#39; function. The integ=
er argument of 32-bit size is expected.</td></tr><tr><td style=3D"padding:0=
px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt=
400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline=
.c">flow_api_hw_db_inline.c (579)</div></td><td style=3D"padding:0px;vertic=
al-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio=
.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical=
-align:top;width:1095.25px">Incorrect format. Consider checking the sixth a=
ctual argument of the &#39;fprintf&#39; function. The integer argument of 3=
2-bit size is expected.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/n=
et/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_=
db_inline.c (579)</div></td><td style=3D"padding:0px;vertical-align:top;wid=
th:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/war=
nings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width=
:1095.25px">Incorrect format. Consider checking the third actual argument o=
f the &#39;fprintf&#39; function. The integer argument of 32-bit size is ex=
pected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/fl=
ow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (581=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Inco=
rrect format. Consider checking the fifth actual argument of the &#39;fprin=
tf&#39; function. The integer argument of 32-bit size is expected.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_=
inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (581)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. C=
onsider checking the fourth actual argument of the &#39;fprintf&#39; functi=
on. The integer argument of 32-bit size is expected.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api=
_hw_db_inline.c">flow_api_hw_db_inline.c (581)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding=
:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider checkin=
g the sixth actual argument of the &#39;fprintf&#39; function. The integer =
argument of 32-bit size is expected.</td></tr><tr><td style=3D"padding:0px;=
vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400=
d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c"=
>flow_api_hw_db_inline.c (581)</div></td><td style=3D"padding:0px;vertical-=
align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.co=
m/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-al=
ign:top;width:1095.25px">Incorrect format. Consider checking the third actu=
al argument of the &#39;fprintf&#39; function. The integer argument of 32-b=
it size is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:t=
op;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/=
ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_=
inline.c (583)</div></td><td style=3D"padding:0px;vertical-align:top;width:=
84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnin=
gs/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:10=
95.25px">Incorrect format. Consider checking the fourth actual argument of =
the &#39;fprintf&#39; function. The integer argument of 32-bit size is expe=
cted.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5p=
x"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow=
_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (583)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorr=
ect format. Consider checking the third actual argument of the &#39;fprintf=
&#39; function. The integer argument of 32-bit size is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D=
"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inl=
ine/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (596)</div></td><td st=
yle=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" h=
ref=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td styl=
e=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Cons=
ider checking the third actual argument of the &#39;fprintf&#39; function. =
The SIGNED integer type argument is expected.</td></tr><tr><td style=3D"pad=
ding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/D=
PDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_=
inline.c">flow_api_hw_db_inline.c (604)</div></td><td style=3D"padding:0px;=
vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1095.25px">Incorrect format. Consider checking the t=
hird actual argument of the &#39;fprintf&#39; function. The SIGNED integer =
type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driver=
s/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_=
hw_db_inline.c (610)</div></td><td style=3D"padding:0px;vertical-align:top;=
width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/=
warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;wi=
dth:1095.25px">Incorrect format. Consider checking the third actual argumen=
t of the &#39;fprintf&#39; function. The SIGNED integer type argument is ex=
pected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/fl=
ow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (618=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Inco=
rrect format. Consider checking the third actual argument of the &#39;fprin=
tf&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"=
/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inli=
ne/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (619)</div></td><td sty=
le=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the third actual argument of the &#39;fprintf&#39; function. T=
he SIGNED integer type argument is expected.</td></tr><tr><td style=3D"padd=
ing:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DP=
DK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_i=
nline.c">flow_api_hw_db_inline.c (620)</div></td><td style=3D"padding:0px;v=
ertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1095.25px">Incorrect format. Consider checking the th=
ird actual argument of the &#39;fprintf&#39; function. The SIGNED integer t=
ype argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-al=
ign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers=
/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_h=
w_db_inline.c (621)</div></td><td style=3D"padding:0px;vertical-align:top;w=
idth:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/w=
arnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;wid=
th:1095.25px">Incorrect format. Consider checking the third actual argument=
 of the &#39;fprintf&#39; function. The SIGNED integer type argument is exp=
ected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5=
px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flo=
w_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (627)=
</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a ta=
rget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576=
</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incor=
rect format. Consider checking the third actual argument of the &#39;fprint=
f&#39; function. The SIGNED integer type argument is expected.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/=
home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inlin=
e/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (628)</div></td><td styl=
e=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hre=
f=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the third actual argument of the &#39;fprintf&#39; function. T=
he SIGNED integer type argument is expected.</td></tr><tr><td style=3D"padd=
ing:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DP=
DK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_i=
nline.c">flow_api_hw_db_inline.c (629)</div></td><td style=3D"padding:0px;v=
ertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1095.25px">Incorrect format. Consider checking the fo=
urth actual argument of the &#39;fprintf&#39; function. The SIGNED integer =
type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driver=
s/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_=
hw_db_inline.c (629)</div></td><td style=3D"padding:0px;vertical-align:top;=
width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/=
warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;wi=
dth:1095.25px">Incorrect format. Consider checking the third actual argumen=
t of the &#39;fprintf&#39; function. The SIGNED integer type argument is ex=
pected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/fl=
ow_api/profile_inline/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (636=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V57=
6</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Inco=
rrect format. Consider checking the third actual argument of the &#39;fprin=
tf&#39; function. The SIGNED integer type argument is expected.</td></tr><t=
r><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"=
/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inli=
ne/flow_api_hw_db_inline.c">flow_api_hw_db_inline.c (706)</div></td><td sty=
le=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v1037/">V1037</a></td><td sty=
le=3D"padding:0px;vertical-align:top;width:1095.25px">Two or more case-bran=
ches perform the same actions. Check lines: 706, 736, 742</td></tr><tr><td =
style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/=
shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flo=
w_api_profile_inline.c">flow_api_profile_inline.c (117)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v629/">V629</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Consider inspecting the=
 &#39;1 &lt;&lt; (shift - 1)&#39; expression. Bit shifting of the 32-bit va=
lue with a subsequent expansion to the 64-bit type.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api=
_profile_inline.c">flow_api_profile_inline.c (738)</div></td><td style=3D"p=
adding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"h=
ttps://pvs-studio.com/en/docs/warnings/v674/">V674</a></td><td style=3D"pad=
ding:0px;vertical-align:top;width:1095.25px">The &#39;0.01&#39; literal of =
the &#39;double&#39; type is compared to a value of the &#39;int&#39; type.=
 Consider inspecting the &#39;0.01 &gt; 0&#39; expression.</td></tr><tr><td=
 style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home=
/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/fl=
ow_api_profile_inline.c">flow_api_profile_inline.c (3469)</div></td><td sty=
le=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v522/">V522</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">There might be derefere=
ncing of a potential null pointer &#39;fh&#39;. Check lines: 3469, 3467.</t=
d></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div =
title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/pro=
file_inline/flow_api_profile_inline.c">flow_api_profile_inline.c (4925)</di=
v></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v522/">V522</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">There mig=
ht be dereferencing of a potential null pointer &#39;template&#39;. Check l=
ines: 4925, 4923.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;=
width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntn=
ic/nthw/flow_api/profile_inline/flow_api_profile_inline.c">flow_api_profile=
_inline.c (4990)</div></td><td style=3D"padding:0px;vertical-align:top;widt=
h:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warn=
ings/v522/">V522</a></td><td style=3D"padding:0px;vertical-align:top;width:=
1095.25px">There might be dereferencing of a potential null pointer &#39;te=
mplate&#39;. Check lines: 4990, 4988.</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt40=
0d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline=
.c">flow_api_profile_inline.c (5262)</div></td><td style=3D"padding:0px;ver=
tical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-stu=
dio.com/en/docs/warnings/v522/">V522</a></td><td style=3D"padding:0px;verti=
cal-align:top;width:1095.25px">There might be dereferencing of a potential =
null pointer &#39;fh&#39;. Check lines: 5262, 5260.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api=
_profile_inline.c">flow_api_profile_inline.c (4307)</div></td><td style=3D"=
padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"=
https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"pa=
dding:0px;vertical-align:top;width:1095.25px">Expression &#39;err&#39; is a=
lways false.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width=
:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nt=
hw/flow_api/profile_inline/flow_api_profile_inline.c">flow_api_profile_inli=
ne.c (2040)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.=
25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/=
v560/">V560</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.=
25px">A part of conditional expression is always true: match_cnt =3D=3D 1.<=
/td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><di=
v title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/p=
rofile_inline/flow_api_profile_inline.c">flow_api_profile_inline.c (196)</d=
iv></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a targe=
t=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The po=
inter is cast to a more strictly aligned pointer type</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_ap=
i_profile_inline.c">flow_api_profile_inline.c (254)</div></td><td style=3D"=
padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"=
https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td style=3D"=
padding:0px;vertical-align:top;width:1095.25px">The pointer is cast to a mo=
re strictly aligned pointer type</td></tr><tr><td style=3D"padding:0px;vert=
ical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/=
drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c">f=
low_api_profile_inline.c (294)</div></td><td style=3D"padding:0px;vertical-=
align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.co=
m/en/docs/warnings/v1032/">V1032</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1095.25px">The pointer is cast to a more strictly aligned p=
ointer type</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:=
505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nth=
w/flow_api/profile_inline/flow_api_profile_inline.c">flow_api_profile_inlin=
e.c (347)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25=
px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1=
032/">V1032</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.=
25px">The pointer is cast to a more strictly aligned pointer type</td></tr>=
<tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_=
inline/flow_api_profile_inline.c">flow_api_profile_inline.c (434)</div></td=
><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_b=
lank" href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td=
><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The pointer &=
#39;data&#39; is cast to a more strictly aligned pointer type.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/=
home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inlin=
e/flow_api_profile_inline.c">flow_api_profile_inline.c (510)</div></td><td =
style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank"=
 href=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td =
style=3D"padding:0px;vertical-align:top;width:1095.25px">The pointer &#39;d=
ata&#39; is cast to a more strictly aligned pointer type.</td></tr><tr><td =
style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/=
shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flo=
w_api_profile_inline.c">flow_api_profile_inline.c (980)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v1032/">V1032</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">The pointer is cast to =
a more strictly aligned pointer type</td></tr><tr><td style=3D"padding:0px;=
vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400=
d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.=
c">flow_api_profile_inline.c (4758)</div></td><td style=3D"padding:0px;vert=
ical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-stud=
io.com/en/docs/warnings/v523/">V523</a></td><td style=3D"padding:0px;vertic=
al-align:top;width:1095.25px">The &#39;then&#39; statement is equivalent to=
 the &#39;else&#39; statement.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/dr=
ivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c">flo=
w_api_profile_inline.c (2272)</div></td><td style=3D"padding:0px;vertical-a=
lign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com=
/en/docs/warnings/v525/">V525</a></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:1095.25px">The code contains the collection of similar blocks.=
 Check items &#39;qw_data&#39;, &#39;qw_data&#39;, &#39;qw_mask&#39; in lin=
es 2272, 2273, 2275.</td></tr><tr><td style=3D"padding:0px;vertical-align:t=
op;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/=
ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c">flow_api_prof=
ile_inline.c (1160)</div></td><td style=3D"padding:0px;vertical-align:top;w=
idth:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/w=
arnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;wid=
th:1095.25px">Incorrect format. Consider checking the eighth actual argumen=
t of the &#39;rte_log&#39; function. The UNSIGNED integer type argument is =
expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:50=
5.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/=
flow_api/profile_inline/flow_api_profile_inline.c">flow_api_profile_inline.=
c (1224)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Incorrect format. Consider checking the fifth actual argument of the &#3=
9;rte_log&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profi=
le_inline/flow_api_profile_inline.c">flow_api_profile_inline.c (3133)</div>=
</td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect=
 format. Consider checking the fifth actual argument of the &#39;rte_log&#3=
9; function. The SIGNED integer type argument is expected.</td></tr><tr><td=
 style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home=
/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/fl=
ow_api_profile_inline.c">flow_api_profile_inline.c (4507)</div></td><td sty=
le=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hr=
ef=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the fifth actual argument of the &#39;rte_log&#39; function. T=
he SIGNED integer type argument is expected.</td></tr><tr><td style=3D"padd=
ing:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DP=
DK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile=
_inline.c">flow_api_profile_inline.c (3573)</div></td><td style=3D"padding:=
0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://=
pvs-studio.com/en/docs/warnings/v1048/">V1048</a></td><td style=3D"padding:=
0px;vertical-align:top;width:1095.25px">The &#39;action_set_data.contains_j=
ump&#39; variable was assigned the same value.</td></tr><tr><td style=3D"pa=
dding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/=
DPDK/nt400d13/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profi=
le_inline.c">flow_api_profile_inline.c (972)</div></td><td style=3D"padding=
:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https:/=
/pvs-studio.com/en/docs/warnings/v1051/">V1051</a></td><td style=3D"padding=
:0px;vertical-align:top;width:1095.25px">Consider checking for misprints. I=
t&#39;s possible that the &#39;flm_id&#39; should be checked here.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_=
nthw_cat.c">flow_nthw_cat.c (29)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1095.25px">The compiler could delete the &#39;memset&#39; f=
unction call, which is used to flush &#39;p&#39; object. The memset_s() fun=
ction should be used to erase the private data.</td></tr><tr><td style=3D"p=
adding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger=
/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_nthw_csu.c">flow_nth=
w_csu.c (33)</div></td><td style=3D"padding:0px;vertical-align:top;width:84=
.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings=
/v597/">V597</a></td><td style=3D"padding:0px;vertical-align:top;width:1095=
.25px">The compiler could delete the &#39;memset&#39; function call, which =
is used to flush &#39;p&#39; object. The memset_s() function should be used=
 to erase the private data.</td></tr><tr><td style=3D"padding:0px;vertical-=
align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drive=
rs/net/ntnic/nthw/flow_filter/flow_nthw_flm.c">flow_nthw_flm.c (30)</div></=
td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"=
_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v597/">V597</a></td=
><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The compiler =
could delete the &#39;memset&#39; function call, which is used to flush &#3=
9;p&#39; object. The memset_s() function should be used to erase the privat=
e data.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/fl=
ow_filter/flow_nthw_flm.c">flow_nthw_flm.c (736)</div></td><td style=3D"pad=
ding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v1020/">V1020</a></td><td style=3D"pad=
ding:0px;vertical-align:top;width:1095.25px">The function exited without ca=
lling the &#39;rte_spinlock_unlock&#39; function. Check lines: 736, 729.</t=
d></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div =
title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/=
flow_nthw_hfu.c">flow_nthw_hfu.c (33)</div></td><td style=3D"padding:0px;ve=
rtical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-st=
udio.com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;vert=
ical-align:top;width:1095.25px">The compiler could delete the &#39;memset&#=
39; function call, which is used to flush &#39;p&#39; object. The memset_s(=
) function should be used to erase the private data.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_nthw_hsh.c">flo=
w_nthw_hsh.c (34)</div></td><td style=3D"padding:0px;vertical-align:top;wid=
th:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/war=
nings/v597/">V597</a></td><td style=3D"padding:0px;vertical-align:top;width=
:1095.25px">The compiler could delete the &#39;memset&#39; function call, w=
hich is used to flush &#39;p&#39; object. The memset_s() function should be=
 used to erase the private data.</td></tr><tr><td style=3D"padding:0px;vert=
ical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/=
drivers/net/ntnic/nthw/flow_filter/flow_nthw_info.c">flow_nthw_info.c (34)<=
/div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a tar=
get=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v597/">V597<=
/a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The co=
mpiler could delete the &#39;memset&#39; function call, which is used to fl=
ush &#39;p&#39; object. The memset_s() function should be used to erase the=
 private data.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/=
nthw/flow_filter/flow_nthw_km.c">flow_nthw_km.c (43)</div></td><td style=3D=
"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D=
"https://pvs-studio.com/en/docs/warnings/v597/">V597</a></td><td style=3D"p=
adding:0px;vertical-align:top;width:1095.25px">The compiler could delete th=
e &#39;memset&#39; function call, which is used to flush &#39;p&#39; object=
. The memset_s() function should be used to erase the private data.</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_=
nthw_pdb.c">flow_nthw_pdb.c (34)</div></td><td style=3D"padding:0px;vertica=
l-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.=
com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;vertical-=
align:top;width:1095.25px">The compiler could delete the &#39;memset&#39; f=
unction call, which is used to flush &#39;p&#39; object. The memset_s() fun=
ction should be used to erase the private data.</td></tr><tr><td style=3D"p=
adding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger=
/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_nthw_qsl.c">flow_nth=
w_qsl.c (34)</div></td><td style=3D"padding:0px;vertical-align:top;width:84=
.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings=
/v597/">V597</a></td><td style=3D"padding:0px;vertical-align:top;width:1095=
.25px">The compiler could delete the &#39;memset&#39; function call, which =
is used to flush &#39;p&#39; object. The memset_s() function should be used=
 to erase the private data.</td></tr><tr><td style=3D"padding:0px;vertical-=
align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drive=
rs/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c">flow_nthw_rpp_lr.c (33)</=
div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a targ=
et=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v597/">V597</=
a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">The com=
piler could delete the &#39;memset&#39; function call, which is used to flu=
sh &#39;p&#39; object. The memset_s() function should be used to erase the =
private data.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;widt=
h:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/n=
thw/flow_filter/flow_nthw_rpp_lr.c">flow_nthw_rpp_lr.c (65)</div></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" =
href=3D"https://pvs-studio.com/en/docs/warnings/v1004/">V1004</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1095.25px">The &#39;p-&gt;m_rp=
p_lr&#39; pointer was used unsafely after it was verified against nullptr. =
Check lines: 57, 65.</td></tr><tr><td style=3D"padding:0px;vertical-align:t=
op;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/=
ntnic/nthw/flow_filter/flow_nthw_slc_lr.c">flow_nthw_slc_lr.c (34)</div></t=
d><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_=
blank" href=3D"https://pvs-studio.com/en/docs/warnings/v597/">V597</a></td>=
<td style=3D"padding:0px;vertical-align:top;width:1095.25px">The compiler c=
ould delete the &#39;memset&#39; function call, which is used to flush &#39=
;p&#39; object. The memset_s() function should be used to erase the private=
 data.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5=
px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flo=
w_filter/flow_nthw_tx_cpy.c">flow_nthw_tx_cpy.c (34)</div></td><td style=3D=
"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D=
"https://pvs-studio.com/en/docs/warnings/v597/">V597</a></td><td style=3D"p=
adding:0px;vertical-align:top;width:1095.25px">The compiler could delete th=
e &#39;memset&#39; function call, which is used to flush &#39;p&#39; object=
. The memset_s() function should be used to erase the private data.</td></t=
r><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_=
nthw_tx_ins.c">flow_nthw_tx_ins.c (33)</div></td><td style=3D"padding:0px;v=
ertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1095.25px">The compiler could delete the &#39;memset&=
#39; function call, which is used to flush &#39;p&#39; object. The memset_s=
() function should be used to erase the private data.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c"=
>flow_nthw_tx_rpl.c (33)</div></td><td style=3D"padding:0px;vertical-align:=
top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/d=
ocs/warnings/v597/">V597</a></td><td style=3D"padding:0px;vertical-align:to=
p;width:1095.25px">The compiler could delete the &#39;memset&#39; function =
call, which is used to flush &#39;p&#39; object. The memset_s() function sh=
ould be used to erase the private data.</td></tr><tr><td style=3D"padding:0=
px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt=
400d13/drivers/net/ntnic/nthw/model/nthw_fpga_model.c">nthw_fpga_model.c (4=
91)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a=
 target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v595/">V=
595</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Th=
e &#39;p-&gt;m_rpp_lr&#39; pointer was utilized before it was verified agai=
nst nullptr. Check lines: &#39;nthw_fpga_model.c:479&#39;, &#39;nthw_fpga_m=
odel.c:491&#39;, &#39;flow_nthw_rpp_lr.c:65&#39;, &#39;flow_nthw_rpp_lr.c:6=
9&#39;.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/mo=
del/nthw_fpga_model.c">nthw_fpga_model.c (186)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v597/">V597</a></td><td style=3D"padding=
:0px;vertical-align:top;width:1095.25px">The compiler could delete the &#39=
;memset&#39; function call, which is used to flush &#39;p&#39; object. The =
memset_s() function should be used to erase the private data.</td></tr><tr>=
<td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/h=
ome/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/model/nthw_fpga_model.c=
">nthw_fpga_model.c (365)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v522/">V522</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1095.25px">Dereferencing of the null pointer might take place. The=
 potential null pointer is passed into &#39;nthw_fpga_get_param_info&#39; f=
unction. Inspect the second argument. Check lines: &#39;nthw_fpga_model.c:3=
65&#39;, &#39;nthw_fpga.c:25&#39;, &#39;nthw_fpga.c:687&#39;.</td></tr><tr>=
<td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/h=
ome/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/model/nthw_fpga_model.c=
">nthw_fpga_model.c (906)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1095.25px">Incorrect format. Consider checking the 14th actual arg=
ument of the &#39;rte_log&#39; function. The SIGNED integer type argument i=
s expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:=
505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nth=
w/model/nthw_fpga_model.c">nthw_fpga_model.c (906)</div></td><td style=3D"p=
adding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"h=
ttps://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"pad=
ding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider che=
cking the sixth actual argument of the &#39;rte_log&#39; function. The SIGN=
ED integer type argument is expected.</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt40=
0d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (515)</div></td><td styl=
e=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hre=
f=3D"https://pvs-studio.com/en/docs/warnings/v547/">V547</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Expression &#39;(word_c=
nt + 3) &gt; (0x4000)&#39; is always false.</td></tr><tr><td style=3D"paddi=
ng:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPD=
K/nt400d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (34)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v575/">V575</a></td><td s=
tyle=3D"padding:0px;vertical-align:top;width:1095.25px">The potential null =
pointer is passed into &#39;memset&#39; function. Inspect the first argumen=
t. Check lines: 34, 33.</td></tr><tr><td style=3D"padding:0px;vertical-alig=
n:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/n=
et/ntnic/nthw/nthw_rac.c">nthw_rac.c (265)</div></td><td style=3D"padding:0=
px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://p=
vs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px=
;vertical-align:top;width:1095.25px">Incorrect format. Consider checking th=
e eighth actual argument of the &#39;rte_log&#39; function. The SIGNED inte=
ger type argument is expected.</td></tr><tr><td style=3D"padding:0px;vertic=
al-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/dr=
ivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (469)</div></td><td style=3D"pa=
dding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"ht=
tps://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padd=
ing:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider chec=
king the eighth actual argument of the &#39;rte_log&#39; function. The SIGN=
ED integer type argument is expected.</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt40=
0d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (508)</div></td><td styl=
e=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" hre=
f=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the eighth actual argument of the &#39;rte_log&#39; function. =
The SIGNED integer type argument is expected.</td></tr><tr><td style=3D"pad=
ding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/D=
PDK/nt400d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (560)</div></td>=
<td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_bl=
ank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><t=
d style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format=
. Consider checking the sixth actual argument of the &#39;rte_log&#39; func=
tion. The SIGNED integer type argument is expected.</td></tr><tr><td style=
=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemm=
inger/DPDK/nt400d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (578)</di=
v></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect=
 format. Consider checking the sixth actual argument of the &#39;rte_log&#3=
9; function. The SIGNED integer type argument is expected.</td></tr><tr><td=
 style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home=
/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac.c (74=
7)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a =
target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V5=
76</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Inc=
orrect format. Consider checking the sixth actual argument of the &#39;rte_=
log&#39; function. The SIGNED integer type argument is expected.</td></tr><=
tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D=
"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/nthw_rac.c">nthw_rac=
.c (768)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Incorrect format. Consider checking the sixth actual argument of the &#3=
9;rte_log&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/nthw_rac.c">nt=
hw_rac.c (94)</div></td><td style=3D"padding:0px;vertical-align:top;width:8=
4.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v1048/">V1048</a></td><td style=3D"padding:0px;vertical-align:top;width:1=
095.25px">The &#39;p-&gt;mp_reg_dbg_data&#39; variable was assigned the sam=
e value.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505=
.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/n=
tnic_meter/ntnic_meter.c">ntnic_meter.c (89)</div></td><td style=3D"padding=
:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https:/=
/pvs-studio.com/en/docs/warnings/v525/">V525</a></td><td style=3D"padding:0=
px;vertical-align:top;width:1095.25px">The code contains the collection of =
similar blocks. Check items &#39;0&#39;, &#39;1&#39;, &#39;0&#39;, &#39;0&#=
39;, &#39;0&#39;, &#39;0&#39; in lines 89, 90, 91, 94, 95, 96.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/=
home/shemminger/DPDK/nt400d13/drivers/net/ntnic/nthw/stat/nthw_stat.c">nthw=
_stat.c (257)</div></td><td style=3D"padding:0px;vertical-align:top;width:8=
4.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warning=
s/v1048/">V1048</a></td><td style=3D"padding:0px;vertical-align:top;width:1=
095.25px">The &#39;p-&gt;mn_stat_layout_version&#39; variable was assigned =
the same value.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wi=
dth:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic=
/ntnic_ethdev.c">ntnic_ethdev.c (2194)</div></td><td style=3D"padding:0px;v=
ertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v547/">V547</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1095.25px">Expression &#39;err =3D=3D 0&#39; is alway=
s true.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.=
5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_e=
thdev.c">ntnic_ethdev.c (334)</div></td><td style=3D"padding:0px;vertical-a=
lign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com=
/en/docs/warnings/v595/">V595</a></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:1095.25px">The &#39;internals-&gt;p_drv&#39; pointer was utili=
zed before it was verified against nullptr. Check lines: 334, 350.</td></tr=
><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=
=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_=
ethdev.c (2268)</div></td><td style=3D"padding:0px;vertical-align:top;width=
:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warni=
ngs/v547/">V547</a></td><td style=3D"padding:0px;vertical-align:top;width:1=
095.25px">Expression &#39;(1 &lt;&lt; n_intf_no) &amp; ~n_port_mask&#39; is=
 always false.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wid=
th:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/=
ntnic_ethdev.c">ntnic_ethdev.c (191)</div></td><td style=3D"padding:0px;ver=
tical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-stu=
dio.com/en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0px;verti=
cal-align:top;width:1095.25px">A part of conditional expression is always f=
alse: !p_nt4ga_stat.</td></tr><tr><td style=3D"padding:0px;vertical-align:t=
op;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/=
ntnic/ntnic_ethdev.c">ntnic_ethdev.c (238)</div></td><td style=3D"padding:0=
px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://p=
vs-studio.com/en/docs/warnings/v560/">V560</a></td><td style=3D"padding:0px=
;vertical-align:top;width:1095.25px">A part of conditional expression is al=
ways false: !p_nt4ga_stat.</td></tr><tr><td style=3D"padding:0px;vertical-a=
lign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/driver=
s/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (1763)</div></td><td style=3D"pa=
dding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"ht=
tps://pvs-studio.com/en/docs/warnings/v1044/">V1044</a></td><td style=3D"pa=
dding:0px;vertical-align:top;width:1095.25px">Loop break conditions do not =
depend on the number of iterations.</td></tr><tr><td style=3D"padding:0px;v=
ertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d=
13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (1900)</div></td><td st=
yle=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" h=
ref=3D"https://pvs-studio.com/en/docs/warnings/v1044/">V1044</a></td><td st=
yle=3D"padding:0px;vertical-align:top;width:1095.25px">Loop break condition=
s do not depend on the number of iterations.</td></tr><tr><td style=3D"padd=
ing:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DP=
DK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (1935)</div></=
td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"=
_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1044/">V1044</a></=
td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Loop break =
conditions do not depend on the number of iterations.</td></tr><tr><td styl=
e=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shem=
minger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (1942=
)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a t=
arget=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v1044/">V1=
044</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Lo=
op break conditions do not depend on the number of iterations.</td></tr><tr=
><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/=
home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethde=
v.c (1370)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.2=
5px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v=
547/">V547</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.2=
5px">Expression &#39;port =3D=3D internals-&gt;n_intf_no&#39; is always tru=
e.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px">=
<div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev=
.c">ntnic_ethdev.c (1396)</div></td><td style=3D"padding:0px;vertical-align=
:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/=
docs/warnings/v547/">V547</a></td><td style=3D"padding:0px;vertical-align:t=
op;width:1095.25px">Expression &#39;port =3D=3D internals-&gt;n_intf_no&#39=
; is always true.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;=
width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntn=
ic/ntnic_ethdev.c">ntnic_ethdev.c (375)</div></td><td style=3D"padding:0px;=
vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-=
studio.com/en/docs/warnings/v574/">V574</a></td><td style=3D"padding:0px;ve=
rtical-align:top;width:1095.25px">The &#39;hw_recv&#39; pointer is used sim=
ultaneously as an array and as a pointer to single object. Check lines: 375=
, 457.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5=
px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_et=
hdev.c">ntnic_ethdev.c (844)</div></td><td style=3D"padding:0px;vertical-al=
ign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/=
en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-alig=
n:top;width:1095.25px">Incorrect format. Consider checking the sixth actual=
 argument of the &#39;rte_log&#39; function. The SIGNED integer type argume=
nt is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wi=
dth:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic=
/ntnic_ethdev.c">ntnic_ethdev.c (866)</div></td><td style=3D"padding:0px;ve=
rtical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-st=
udio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vert=
ical-align:top;width:1095.25px">Incorrect format. Consider checking the ten=
th actual argument of the &#39;rte_log&#39; function. The SIGNED integer ty=
pe argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-ali=
gn:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/=
net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (907)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding=
:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider checkin=
g the sixth actual argument of the &#39;rte_log&#39; function. The SIGNED i=
nteger type argument is expected.</td></tr><tr><td style=3D"padding:0px;ver=
tical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13=
/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (974)</div></td><td style=
=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=
=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=
=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Consi=
der checking the seventh actual argument of the &#39;rte_log&#39; function.=
 The UNSIGNED integer type argument is expected.</td></tr><tr><td style=3D"=
padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemminge=
r/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (974)</div=
></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=
=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a>=
</td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect=
 format. Consider checking the sixth actual argument of the &#39;rte_log&#3=
9; function. The UNSIGNED integer type argument is expected.</td></tr><tr><=
td style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/ho=
me/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.=
c (1012)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25p=
x"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v57=
6/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25p=
x">Incorrect format. Consider checking the fifth actual argument of the &#3=
9;rte_log&#39; function. The SIGNED integer type argument is expected.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntn=
ic_ethdev.c (1042)</div></td><td style=3D"padding:0px;vertical-align:top;wi=
dth:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/wa=
rnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-align:top;widt=
h:1095.25px">Incorrect format. Consider checking the fifth actual argument =
of the &#39;rte_log&#39; function. The SIGNED integer type argument is expe=
cted.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5p=
x"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_eth=
dev.c">ntnic_ethdev.c (1076)</div></td><td style=3D"padding:0px;vertical-al=
ign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/=
en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;vertical-alig=
n:top;width:1095.25px">Incorrect format. Consider checking the fifth actual=
 argument of the &#39;rte_log&#39; function. The SIGNED integer type argume=
nt is expected.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;wi=
dth:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic=
/ntnic_ethdev.c">ntnic_ethdev.c (1136)</div></td><td style=3D"padding:0px;v=
ertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-s=
tudio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;ver=
tical-align:top;width:1095.25px">Incorrect format. Consider checking the fi=
fth actual argument of the &#39;rte_log&#39; function. The SIGNED integer t=
ype argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-al=
ign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers=
/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (1277)</div></td><td style=3D"pad=
ding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"htt=
ps://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1095.25px">Incorrect format. Consider check=
ing the sixth actual argument of the &#39;rte_log&#39; function. The UNSIGN=
ED integer type argument is expected.</td></tr><tr><td style=3D"padding:0px=
;vertical-align:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt40=
0d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (1335)</div></td><td =
style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank"=
 href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a></td><td st=
yle=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrect format. Co=
nsider checking the sixth actual argument of the &#39;rte_log&#39; function=
. The UNSIGNED integer type argument is expected.</td></tr><tr><td style=3D=
"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/shemming=
er/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c (2302)</d=
iv></td><td style=3D"padding:0px;vertical-align:top;width:84.25px"><a targe=
t=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576/">V576</a=
></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px">Incorrec=
t format. Consider checking the sixth actual argument of the &#39;rte_log&#=
39; function. The SIGNED integer type argument is expected.</td></tr><tr><t=
d style=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/hom=
e/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_ethdev.c">ntnic_ethdev.c=
 (2308)</div></td><td style=3D"padding:0px;vertical-align:top;width:84.25px=
"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings/v576=
/">V576</a></td><td style=3D"padding:0px;vertical-align:top;width:1095.25px=
">Incorrect format. Consider checking the sixth actual argument of the &#39=
;rte_log&#39; function. The SIGNED integer type argument is expected.</td><=
/tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div tit=
le=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_filter/ntnic_f=
ilter.c">ntnic_filter.c (481)</div></td><td style=3D"padding:0px;vertical-a=
lign:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com=
/en/docs/warnings/v595/">V595</a></td><td style=3D"padding:0px;vertical-ali=
gn:top;width:1095.25px">The &#39;internals&#39; pointer was utilized before=
 it was verified against nullptr. Check lines: 481, 487.</td></tr><tr><td s=
tyle=3D"padding:0px;vertical-align:top;width:505.5px"><div title=3D"/home/s=
hemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_filter/ntnic_filter.c">ntni=
c_filter.c (1159)</div></td><td style=3D"padding:0px;vertical-align:top;wid=
th:84.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/war=
nings/v560/">V560</a></td><td style=3D"padding:0px;vertical-align:top;width=
:1095.25px">A part of conditional expression is always false: !p_nt4ga_stat=
.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><=
div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_filter/=
ntnic_filter.c">ntnic_filter.c (357)</div></td><td style=3D"padding:0px;ver=
tical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https://pvs-stu=
dio.com/en/docs/warnings/v576/">V576</a></td><td style=3D"padding:0px;verti=
cal-align:top;width:1095.25px">Incorrect format. Consider checking the fift=
h actual argument of the &#39;rte_log&#39; function. The UNSIGNED integer t=
ype argument is expected.</td></tr><tr><td style=3D"padding:0px;vertical-al=
ign:top;width:505.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers=
/net/ntnic/ntnic_filter/ntnic_filter.c">ntnic_filter.c (1121)</div></td><td=
 style=3D"padding:0px;vertical-align:top;width:84.25px"><a target=3D"_blank=
" href=3D"https://pvs-studio.com/en/docs/warnings/v1027/">V1027</a></td><td=
 style=3D"padding:0px;vertical-align:top;width:1095.25px">Pointer to an obj=
ect of the &#39;flow_handle&#39; class is cast to unrelated &#39;rte_flow&#=
39; class.</td></tr><tr><td style=3D"padding:0px;vertical-align:top;width:5=
05.5px"><div title=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntni=
c_filter/ntnic_filter.c">ntnic_filter.c (1143)</div></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:84.25px"><a target=3D"_blank" href=3D"https=
://pvs-studio.com/en/docs/warnings/v1027/">V1027</a></td><td style=3D"paddi=
ng:0px;vertical-align:top;width:1095.25px">Pointer to an object of the &#39=
;rte_flow&#39; class is cast to unrelated &#39;flow_handle&#39; class.</td>=
</tr><tr><td style=3D"padding:0px;vertical-align:top;width:505.5px"><div ti=
tle=3D"/home/shemminger/DPDK/nt400d13/drivers/net/ntnic/ntnic_vfio.c">ntnic=
_vfio.c (81)</div></td><td style=3D"padding:0px;vertical-align:top;width:84=
.25px"><a target=3D"_blank" href=3D"https://pvs-studio.com/en/docs/warnings=
/v1048/">V1048</a></td><td style=3D"padding:0px;vertical-align:top;width:10=
95.25px">The &#39;vfio-&gt;container_fd&#39; variable was assigned the same=
 value.</td></tr></tbody></table></div></div></div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Feb 20, 2025 at 2:04=E2=80=AFPM Serhii Iliushyk &lt;<a href=3D"mailto:sil-p=
lv@napatech.com">sil-plv@napatech.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">This patchset adds support for the new=
 adapter NT400D13.<br>
<br>
Danylo Vodopianov (23):<br>
=C2=A0 net/ntnic: add link agx 100g<br>
=C2=A0 net/ntnic: add link state machine<br>
=C2=A0 net/ntnic: add rpf and gfg init<br>
=C2=A0 net/ntnic: add agx setup for port<br>
=C2=A0 net/ntnic: add host loopback init<br>
=C2=A0 net/ntnic: add line loopback init<br>
=C2=A0 net/ntnic: add 100 gbps port init<br>
=C2=A0 net/ntnic: add port post init<br>
=C2=A0 net/ntnic: add nim low power API<br>
=C2=A0 net/ntnic: add link handling API<br>
=C2=A0 net/ntnic: add port init to the state machine<br>
=C2=A0 net/ntnic: add port disable API<br>
=C2=A0 net/ntnic: add nt400d13 pcm init<br>
=C2=A0 net/ntnic: add HIF clock test<br>
=C2=A0 net/ntnic: add nt400d13 PRM module init<br>
=C2=A0 net/ntnic: add nt400d13 PRM module reset<br>
=C2=A0 net/ntnic: add SPI v3 support for FPGA<br>
=C2=A0 net/ntnic: add i2cm init<br>
=C2=A0 net/ntnic: add pca init<br>
=C2=A0 net/ntnic: add pcal init<br>
=C2=A0 net/ntnic: add reset PHY init<br>
=C2=A0 net/ntnic: add igam module init<br>
=C2=A0 net/ntnic: init IGAM and config PLL for FPGA<br>
<br>
Serhii Iliushyk (9):<br>
=C2=A0 net/ntnic: add minimal initialization new NIC NT400D13<br>
=C2=A0 net/ntnic: add minimal reset FPGA<br>
=C2=A0 net/ntnic: add FPGA modules and registers<br>
=C2=A0 net/ntnic: add setup for fpga reset<br>
=C2=A0 net/ntnic: add default reset setting for NT400D13<br>
=C2=A0 net/ntnic: add DDR calibration to reset stage<br>
=C2=A0 net/ntnic: add PHY ftile reset<br>
=C2=A0 net/ntnic: add clock init<br>
=C2=A0 net/ntnic: revert untrusted loop bound<br>
<br>
=C2=A0doc/guides/nics/ntnic.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 7 +-<br>
=C2=A0doc/guides/rel_notes/release_25_03.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 4 +<br>
=C2=A0drivers/net/ntnic/adapter/nt4ga_adapter.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 9 +<br>
=C2=A0drivers/net/ntnic/include/nt4ga_link.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 7 +<br>
=C2=A0drivers/net/ntnic/include/nthw_gfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A033 +<br>
=C2=A0drivers/net/ntnic/include/ntnic_nim.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 5 +<br>
=C2=A0.../include/ntnic_nthw_fpga_rst_nt400dxx.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A034 +<br>
=C2=A0.../link_agx_100g/nt4ga_agx_link_100g.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
029 ++++++<br>
=C2=A0drivers/net/ntnic/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A016 +<br>
=C2=A0drivers/net/ntnic/nim/i2c_nim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 158 +-<br>
=C2=A0drivers/net/ntnic/nim/i2c_nim.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +<br>
=C2=A0...00D13_U62_Si5332-GM2-RevD-1_V5-Registers.h |=C2=A0 425 +++<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_fpga.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A010 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_gmf.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 2 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_hif.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 4 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_i2cm.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A0 3 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_igam.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A040 +<br>
=C2=A0.../ntnic/nthw/core/include/nthw_pca9532.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A025 +<br>
=C2=A0.../ntnic/nthw/core/include/nthw_pcal6416a.h=C2=A0 |=C2=A0 =C2=A033 +=
<br>
=C2=A0.../nthw/core/include/nthw_pcm_nt400dxx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A040 +<br>
=C2=A0.../ntnic/nthw/core/include/nthw_phy_tile.h=C2=A0 =C2=A0|=C2=A0 156 +=
<br>
=C2=A0.../nthw/core/include/nthw_prm_nt400dxx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A032 +<br>
=C2=A0.../nthw/core/include/nthw_si5332_si5156.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A063 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_spi_v3.h |=C2=A0 107 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_spim.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A058 +<br>
=C2=A0.../net/ntnic/nthw/core/include/nthw_spis.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A063 +<br>
=C2=A0.../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c=C2=A0 =C2=A0|=C2=A0 220 +=
+<br>
=C2=A0.../core/nt400dxx/reset/nthw_fpga_rst9574.c=C2=A0 =C2=A0|=C2=A0 377 +=
+<br>
=C2=A0.../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c=C2=A0 =C2=A0|=C2=A0 427 +=
++<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_fpga.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 464 +++<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_gfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 340 ++<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_gmf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A041 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_hif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A092 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_i2cm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 139 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_igam.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A093 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_pca9532.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A060 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_pcal6416a.c=C2=A0 |=C2=A0 103 +<br>
=C2=A0.../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A080 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_phy_tile.c=C2=A0 =C2=A0| 1242 ++++++=
+<br>
=C2=A0.../net/ntnic/nthw/core/nthw_prm_nt400dxx.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A055 +<br>
=C2=A0.../net/ntnic/nthw/core/nthw_si5332_si5156.c=C2=A0 |=C2=A0 142 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_spi_v3.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
358 ++<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_spim.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 113 +<br>
=C2=A0drivers/net/ntnic/nthw/core/nthw_spis.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 121 +<br>
=C2=A0drivers/net/ntnic/nthw/nthw_drv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A031 +<br>
=C2=A0drivers/net/ntnic/nthw/nthw_platform.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 3 +<br>
=C2=A0drivers/net/ntnic/nthw/nthw_platform_drv.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 2 +<br>
=C2=A0.../supported/nthw_fpga_9574_055_049_0000.c=C2=A0 =C2=A0| 3124 ++++++=
+++++++++++<br>
=C2=A0.../nthw/supported/nthw_fpga_instances.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 5 +-<br>
=C2=A0.../nthw/supported/nthw_fpga_instances.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 1 +<br>
=C2=A0.../ntnic/nthw/supported/nthw_fpga_mod_defs.h |=C2=A0 =C2=A011 +<br>
=C2=A0.../nthw/supported/nthw_fpga_mod_str_map.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A011 +<br>
=C2=A0.../ntnic/nthw/supported/nthw_fpga_reg_defs.h |=C2=A0 =C2=A011 +<br>
=C2=A0.../nthw/supported/nthw_fpga_reg_defs_igam.h=C2=A0 |=C2=A0 =C2=A032 +=
<br>
=C2=A0.../supported/nthw_fpga_reg_defs_pci_ta.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A033 +<br>
=C2=A0.../nthw_fpga_reg_defs_pcm_nt400dxx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A029 +<br>
=C2=A0.../nthw/supported/nthw_fpga_reg_defs_pdi.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A049 +<br>
=C2=A0.../supported/nthw_fpga_reg_defs_phy_tile.h=C2=A0 =C2=A0|=C2=A0 213 +=
+<br>
=C2=A0.../nthw_fpga_reg_defs_prm_nt400dxx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A026 +<br>
=C2=A0.../nthw/supported/nthw_fpga_reg_defs_rfd.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A038 +<br>
=C2=A0.../supported/nthw_fpga_reg_defs_rst9574.h=C2=A0 =C2=A0 |=C2=A0 =C2=
=A035 +<br>
=C2=A0.../nthw/supported/nthw_fpga_reg_defs_spim.h=C2=A0 |=C2=A0 =C2=A076 +=
<br>
=C2=A0.../nthw/supported/nthw_fpga_reg_defs_spis.h=C2=A0 |=C2=A0 =C2=A051 +=
<br>
=C2=A0.../nthw/supported/nthw_fpga_reg_defs_tint.h=C2=A0 |=C2=A0 =C2=A028 +=
<br>
=C2=A0drivers/net/ntnic/ntnic_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0drivers/net/ntnic/ntnic_filter/ntnic_filter.c |=C2=A0 =C2=A0 2 +-<br>
=C2=A0drivers/net/ntnic/ntnic_mod_reg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A047 +<br>
=C2=A0drivers/net/ntnic/ntnic_mod_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A025 +<br>
=C2=A068 files changed, 10709 insertions(+), 11 deletions(-)<br>
=C2=A0create mode 100644 drivers/net/ntnic/include/nthw_gfg.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt40=
0dxx.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_ag=
x_link_100g.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/NT400D13_U62_S=
i5332-GM2-RevD-1_V5-Registers.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_igam.h<br=
>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pca9532.h=
<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcal6416a=
.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400=
dxx.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_phy_tile.=
h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_prm_nt400=
dxx.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_si5332_si=
5156.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spi_v3.h<=
br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spim.h<br=
>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_spis.h<br=
>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt4=
00dxx.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fp=
ga_rst9574.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fp=
ga_rst_nt400dxx.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_gfg.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_igam.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_pca9532.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c<br=
>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_phy_tile.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c<br=
>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c<b=
r>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_spi_v3.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_spim.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/core/nthw_spis.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_9574_05=
5_049_0000.c<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_igam.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_pci_ta.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_pcm_nt400dxx.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_pdi.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_phy_tile.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_prm_nt400dxx.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_rfd.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_rst9574.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_spim.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_spis.h<br>
=C2=A0create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_def=
s_tint.h<br>
<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div>

--000000000000c2332c062e9b87fd--
