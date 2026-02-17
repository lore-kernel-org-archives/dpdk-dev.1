Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3437FE83848
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 00:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 011134029D;
	Tue, 17 Feb 2026 01:27:51 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 6F4BA4029D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 01:27:49 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4362197d174so2465139f8f.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771288069;
 x=1771892869; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxM5GlQetvx3unTpyVRat9s69PpXE4bgmwzLsnL3bZ0=;
 b=YNjtcUUyX4iW4YGSUA9IJSZBczU2r5quXDNRTDaEu1Qwz7ocYmpiOinryfYawU2cKM
 pj55H9UKtY8eSAnVWbTTARg48JJCNP4iK4FZlvOCoaOFVwMTOmTXclAymGdeIcycdRJc
 NriuCXqd7I/tnhBdQla/IH13jTyCRxZb5g/AWhsSPv5t4yQpx2Q7oLxMvMV5tbnZd55Z
 RzYhY5jabfwil8prevZiGSTL/dpCMmqpuHg4tWCXjEN+InFBqnSaBP7GPxe6XgDqyUmS
 Eu1tSjLStJLnT+7qhZI1cxSFL5qjMOMjytnXSShYiyPNzphStqzBSfScMporStlyRzBe
 143g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771288069; x=1771892869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wxM5GlQetvx3unTpyVRat9s69PpXE4bgmwzLsnL3bZ0=;
 b=qvm1FAsRt8zQ3OJ7jb0o/DGa+K67qGFMwOQSkL1rlc8NtwjciFG85dxOQUlb+jmPwS
 YwanXtAIX9UZF6eubGReBv1VdM7bReD8yAqnEVSUq9HX/6p8Y7j2LF3s+pAg/ZmZEqqA
 VHZBJabRWrwchdQnj4B7UqFnvRfI5IAb2Q8H8LX/dJWu6zb4JspVbz8GoUbZkE3mGjkC
 XHAlAormuaXi2MMsGPcytPTY9XHbZ2/K09kfxN0o+hnAc8QI+CcNxesiUeMt7oKeGR1y
 T5AP0Xzfd5cfYdSquzIsyhQB2ESsiFq2z+zaQlR9qz64ZfF2OpRcEJLLlerDZQ8qxj4V
 y5rg==
X-Gm-Message-State: AOJu0YwsLcKMR6LzmJ1TMAqEC8aaF2C/d2ChYV4nIhgv3v9M6uTCAGHa
 FYCIEHWILkDjX9p1FmX50HWBaB7x13WXQR7cnDh4r2IQSxXt2SfZE8cOYzeRcHZ7ims=
X-Gm-Gg: AZuq6aJYnOu9TA1vJrxxaDVXbogBjc0FDTi4dQOO7EBhPcL1enBMcY47d51MWV/4YnL
 RUQ2gqN4T0IaXEWBJ93ZQbFkiO+HmrOMrFzmE/WwngtTgE6+tjESD79/+qd3L3B4HFTTWhnwhnL
 LvUVBNZHzkSWDX2afrEcsuONUHPX52luHbkNaQhrBrQBRXYrPB2ct8Z5k/sLezFCJyu8YRmTQNB
 XMbUDY/Y3ZO9OFJh1v8b9QcJbNZjxgV/PZzjrMAEz08hp+tmanCTQchYCi+SFCwwDqCwn9120RK
 uIXlrGU4OYqFT7fFnFXVpjIhgkWe6B1j1MFtmofrCLG18cNsayZO6NPs3c1b2abWM5UUv8Pi+f1
 6vxdReT0nKqzZ0PUS74VZeqTEodTZ2a3apOZyPb9nLEXkUzpWYuEF40mOrQm6l1jzqFX/oju5U0
 9PVoQ6VKpjs1i57ECK2qgKXz88mcgt6MID/mpUbsaVc8+1g0BdlQJzj06+q1+lwbQJ
X-Received: by 2002:adf:ce90:0:b0:437:7088:4150 with SMTP id
 ffacd0b85a97d-437978c0a14mr17892068f8f.10.1771288068786; 
 Mon, 16 Feb 2026 16:27:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74704sm32449749f8f.16.2026.02.16.16.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 16:27:47 -0800 (PST)
Date: Mon, 16 Feb 2026 16:27:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH 1/3] net/axgbe: Add external PHY read/write functions
Message-ID: <20260216162741.7f9df17c@phoenix.local>
In-Reply-To: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-1-ashokkumar.natarajan@amd.com>
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

On Mon, 16 Feb 2026 18:22:03 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> Introduce helper functions to perform external PHY register read and
> write operations. These helpers currently support only IEEE Clause 22
> PHY access, providing a simple and consistent API for accessing
> standard 16=E2=80=91bit MII registers on external PHY devices.
>=20
> This patch does not implement Clause 45 transactions; support for C45
> access can be added in future updates as needed.
>=20
> No functional changes are introduced for existing drivers. The new
> helpers will be used by subsequent patches that require external PHY
> management.
>=20
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
> ---

The result of AI review feedback reports some issues that need resolution.
All AI feedback can be wrong, so use this is inspiration.

Correctness issues (must fix):

1. axgbe_get_phy_id() uses the return value of read() directly in
bit-shift arithmetic without checking for errors. If either MDIO read
fails (returns negative), the resulting PHY ID is garbage and could
accidentally match M88E1512_E_PHY_ID, triggering the wrong init
sequence. Please add error checks after each read.

2. axgbe_phy_an_config() silently drops the return value of
axgbe_m88e1512_config_aneg(). That function can fail at multiple points
but the caller always returns 0. Should be: return
axgbe_m88e1512_config_aneg(pdata);

3. axgbe_m88e1512_init() switches PHY pages multiple times but never
restores page 0 on error paths. If a write fails while on page 0xFF or
0x12, all subsequent MDIO accesses from other code paths will hit the
wrong registers. Add an error cleanup label that restores page 0.

4. The read/write helpers (patch 1) don't check the return value of the
underlying read_ext_mii_regs_c22/write_ext_mii_regs_c22 calls. Errors
from the hardware layer pass through silently.

Other items:

5. Function name typo: axgbe_m88e5112_set_page should be axgbe_m88e1512_set=
_page to match the actual PHY model.

6. All three subject lines use uppercase "Add" after the colon =E2=80=94 sh=
ould be lowercase per DPDK convention.

7. Missing space: if(ret) should be if (ret) in the init caller in patch 2.

8. The init function blocks for 2 seconds total (two rte_delay_ms(1000) cal=
ls). Is polling for reset completion feasible instead?

9. Missing release notes for external PHY support and 100M speed =E2=80=94 =
these are user-visible features.

10. Various magic numbers (0x8001, 0x1177, 0xC00D) written to registers wit=
hout defines or comments referencing the datasheet.

Please fix at least items 1-4 and resubmit.

