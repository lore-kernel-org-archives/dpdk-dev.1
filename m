Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B987CFD9E0A
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 20:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E345C402B2;
	Thu, 26 Feb 2026 21:14:30 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 93F954026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 21:14:30 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2bdb17511aaso1239010eec.0
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772136869;
 x=1772741669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UmFi9vYQ0iO4xitGYsNabXqSucn3AfGSm3FPphJims=;
 b=PKU2Fu4lvY5eCw/+sOWdGTCCPF85MdLtrhDRr7bkLELRFYUso8a3/gAjtY5sz90xJF
 +lYibBp8MLwodZV1Rr1D1YpZDc5naldAyRt3qB59Qt2Fv4XKnuNeg26/mVIgpVmtHMcO
 VAqezY4dn/KS+i37fdtzCY79CCr+EMcaUZ+3Fmwf3lmXEWC3787uIOWqc1mOfTJfSu+V
 P5pqdGP9gyODYz0N/EmMguHWMOCWxrOi8NroOMKlEiyf02jdpuKckP1nC9mRVF4Vn94N
 RZYbNh1JDRXuYNjl52Ew0P6ZwQAKHJu/ZmufJA8jPVsKtSNi7YnWxas6/kYg3GdOYh5X
 BsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772136869; x=1772741669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/UmFi9vYQ0iO4xitGYsNabXqSucn3AfGSm3FPphJims=;
 b=GackHXsqUmJktd5ckrf2J5SJ+rASe8siCBx5p0dKSBVfJ0n56FSLE4j6ITAYZMOapf
 Wlv04Y2jgN78Hi9SR8ygkp1sJTxGkEoXoz93s9daO+dV6K/6hl3RY7ipVjm8tsaOJNCq
 7+SRuaZ4pyXG5Wa5Gh90lRYL7W+MP2gpwpFBcgnzmXAceymdg468ASmTtQA4skMkN9Xw
 ui6Yg+ukPoU89iOrITcPEEKYgnIszFzNKAlJcLHHbiwYJGvfoLfGciFMDBK72oi17TE6
 ILTN7xTx/xsVWsKla320eJFI6insNxYC1mGRAZoabdXKTkEEu7vdwC3WC/94L/0PNjTu
 +1XA==
X-Gm-Message-State: AOJu0YwCg+7ZSW1hzPd2678fzUICF/fphL9jr9CTUcruvJS92FhjtPbO
 114PlwlzovCrTmtAq9sK4I9yBNyuUWrmBLLskTkEDUsmnMvPp3mk7MyCHuG22fFe6fxyIXg2br6
 Kd6j1
X-Gm-Gg: ATEYQzx3NY09t5c9+2RkCyVmX4fBp+LPWprMTb7Gz4WtKgbG3kW6Yi1MUSVDzBL2SUG
 eLYkWBQGwF94eentnqB8biraLkjD83dvHsdDZ7tjb+hlrmSFjbs28aM6FgJxO64vuQwHHoxrxeJ
 ZNsjUHLxMUOXJlr60p/xOsnV5r1/MnCEn6Hz3JWlunMo9k2GedXSqKPoOdxt2e3KvfSbY8mxe+I
 nA5VWRO1a1qybWSCcnc5B4pTvOwJX6D05uYAYWMZ67SQVlJFomhG0Sxk2BZrmh4CULoIwZVCR3m
 YRJzPHXjcKpkNiZaoWRe5dTiSBaDBWwWvFonDGi93l0oxveIwpHA4mibN2Gp58YGizdcrXK16+E
 F7vnlHRGewnz1XgTifDwsEu5mO1z+RGqYwvpzvpkirKC+I8t2FiFRhCLGGFQQY6IBjJILA0vPm+
 dHnSBEhDpTIX0ZvkubjM4W2Ck8JYnJDQf3zH+6CiuTH6vxlhNhCoGHuC6N6BKGEfU1
X-Received: by 2002:a05:7300:640c:b0:2bd:d68c:44bf with SMTP id
 5a478bee46e88-2bde1c0f26bmr217169eec.5.1772136869391; 
 Thu, 26 Feb 2026 12:14:29 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1f45e23sm2456046eec.24.2026.02.26.12.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 12:14:29 -0800 (PST)
Date: Thu, 26 Feb 2026 12:14:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v3 1/1] net/nbl: add igb uio support for NBL VF devices
Message-ID: <20260226121426.5f5d0e98@phoenix.local>
In-Reply-To: <20260225033943.30751-2-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
 <20260225033943.30751-1-dimon.zhao@nebula-matrix.com>
 <20260225033943.30751-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 24 Feb 2026 19:39:42 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Due to a chip design limitation, only the VF
> supports the igb_uio driver. The PF does not.
> 
> The igb_uio driver requires allocating interrupts and configuring the
> PCIe MSI-X table before the driver's probe function is called.
> This pre-probe configuration is only possible on the VF due to the
> hardware limitation; the PF can only configure the MSI-X table during
> its probe process.
> 
> Therefore, using igb_uio on the PF will fail.
> This commit clarifies this restriction.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>

The documentation doesn't make it clear that nbl_core is for PF
and igb_uio or vfio-pci should be used for VF.

Is the VF and PF sharing same ops structure?

Also, there should be a entry like this now:
RTE_PMD_REGISTER_KMOD_DEP(net_nbl_vf, "* igb_uio | vfio-pci");
