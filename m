Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7DEEF99D6
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:59:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4EAA402C1;
	Fri, 13 Feb 2026 20:59:50 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id BDC34402C0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:59:49 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so982496f8f.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771012789;
 x=1771617589; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj7myF/fbmO+wxiaS2gr8Byp/hfLasfHGAUuYJQGk6o=;
 b=kRL2Ebci+jDonxGlqjSGnHdGqXssagHGm36GJWSJzdfGOR8lZYwzC0mJhvmQS0Sl2o
 4dwieYBWk3UV8PhTcWubqKGfc8TxnV5GrDOtcZc2Wvev+CypmA5dpCkGJASfZMBuYi/V
 DW9Rkum4kgOK/6W/Ply5Uq0PkOnesk8YGVVuQzw3ZkVg7iskNjKkHzRRSYrjaZnp+naz
 rtDIyVOO/BzgXNC//GKFziIzLwbf5E0gXkTg8nUOYlJuVu2kpjODw2fVmxfbCBvUFckY
 kDojhk8v/GpqqpA9NXHLg8ChyX4htW3yqPS6LZUr1ta9loiWbYxGdhd0OgABa5SsK8fC
 mr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771012789; x=1771617589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vj7myF/fbmO+wxiaS2gr8Byp/hfLasfHGAUuYJQGk6o=;
 b=DwkG5DOLLqyrOfv4eH3C/Na4XGQTtGGSieYh+EDNx+qzCnEbk4RSnqr4KOwRAf/PrD
 RPEUGSewbjhfpGQRT6ClKOr03MXKWrLq4rgHcSJwBBn0ccvihuPu6HlIPyWF7PTBVtFz
 HoNf+sm4vXbMkaXzbm1OjMxb9alMozDpW49QOtGOAcpNmEPeVzsscfD2b8W3jdwZAFQF
 sG/9p/o3ks6dm0VCwBaCDkqdf/RAGHgkVrhjZskwtDr8AusTqCDAVSEnWZb6HK10btTr
 4QnqypmmxfKfqn+k5FLpUJypgvVo29Tion6EfnD72pP/D/TcBo0U65O0VMWjkikdtVsS
 ZwNA==
X-Gm-Message-State: AOJu0Yy903l7GIEx3xkg3nNgRo6jyJcIH53Cx/zJVxoDgf6ar3GMzgp1
 T8o+Gmfr3WdJEWInfOuwJd/RQLjeXEwYFQuSXiysnWiu4imAuU73S8M6QZwLlx12GMqVLaDwq79
 LsP7M
X-Gm-Gg: AZuq6aLl8AThO7VZ/kJkAMEktQsHgXRENC0TAnVtY26dpUfLVeTZIXCsMp2Dlmyx4J/
 syqnRXih63puY2XQfN0bjB6d/l1Pn3I7ukiFbXNLb0H3m2nWP7mMjREqzBMtK1UFcIHiT16wR28
 HLcnoL060WYDCtyG7gzG3nb+25SC+vkzGjAFOL9mNsDs2PFGujp/L2qA2cMTjhNy8NjEFm2QM8j
 /GsGbF/gbc6OQmvwOUVCbcGRn7eqC7FkJr6V08QprgkuRWedSG8wb0Ll2KvV8WrR+WmRdK/po3Y
 X2l3OCjCbE2MM+Ehv9qBHQz7PgjnFfsq8/VwC1l9e0GkAUd3PIykf0IpTAUDFqO3SW1KoOFx0HS
 3/k135pmsX+YyaUuO6P+rpizUbrG+JVvDSST8fNKUM18+kB4QKTyrsk2FqwD4q12+l7tNfV6Qg1
 JGCBlSj+VB4J+KgAsz800EKtw+miKfzSzNSQ1hOlLHyMM/nx/T48Hqb2KY58/hTWVd
X-Received: by 2002:a05:6000:2dc9:b0:435:960c:5286 with SMTP id
 ffacd0b85a97d-43796b0539emr6198140f8f.58.1771012789197; 
 Fri, 13 Feb 2026 11:59:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm7834563f8f.24.2026.02.13.11.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:59:48 -0800 (PST)
Date: Fri, 13 Feb 2026 11:59:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v2 1/1] net/nbl: add igb uio support for NBL VF devices
Message-ID: <20260213115943.6ae598f8@phoenix.local>
In-Reply-To: <20260213112130.49185-2-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
 <20260213112130.49185-1-dimon.zhao@nebula-matrix.com>
 <20260213112130.49185-2-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 13 Feb 2026 03:21:30 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Due to a chip design limitation, only the VF
> supports the igb_uio driver. The PF does not.
>=20
> The igb_uio driver requires allocating interrupts and configuring the
> PCIe MSI-X table before the driver's probe function is called.
> This pre-probe configuration is only possible on the VF due to the
> hardware limitation; the PF can only configure the MSI-X table during
> its probe process.
>=20
> Therefore, using igb_uio on the PF will fail.
> This commit clarifies this restriction.
>=20
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

This looks much better, but  AI still found some issues:


First, there are some correctness concerns:

In nbl_disp_chan_get_global_vector_req(), result.vector_id is copied to
the output regardless of whether send_msg succeeded. If the send fails,
the caller silently gets vector_id 0 which could be a valid ID. Please
guard the assignment with a check on ret.

In nbl_dev_common_start(), the return value of
get_msix_irq_enable_info() is stored in irq_enable_base and immediately
passed to rte_write32() without a NULL check. If it returns NULL,
that's a NULL pointer dereference.

Also in nbl_dev_common_start(), when enable_mailbox_irq fails in the
non-VFIO path, net_msix_mask_en remains true and irq_enable_base
remains set. The interrupt handler could use these in an inconsistent
state. The error path also doesn't undo
get_global_vector/get_msix_irq_enable_info for the igb_uio case, only
calling destroy_msix_map for VFIO.

In nbl_disp_get_global_vector(), ret is declared as u16 but the
function returns int. Negative error codes will be truncated to
unsigned, turning errors into positive values.

Some smaller items:

- NBL_PCOMPLETER_MSIX_NOTIRY_OFFSET has a typo =E2=80=94 should be NOTIFY.
- The memcpy from a bitfield struct into a u32 in
nbl_phy_get_msix_irq_enable_info is fragile since bitfield layout is
compiler-dependent. Consider explicit shifts and masks.
- The u8* declarations in the header files should be u8 * per DPDK
style.
- Double space before NBL_DEVICE_ID_M18100_VF in two places.
- The is_vf assignment can be simplified to: common->is_vf =3D
(pci_dev->id.device_id =3D=3D NBL_DEVICE_ID_M18100_VF);
- In nbl.rst, "not supported on both PF and VF" is ambiguous =E2=80=94 sugg=
est
"not supported on either PF or VF devices" instead.

I can send full long form of report if you want.
The AI review can have false positives. If so, let me know always
trying to fix the prompts to avoid them.
