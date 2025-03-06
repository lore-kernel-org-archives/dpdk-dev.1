Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E342FC28B25
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Mar 2025 12:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B11F402A0;
	Sun,  9 Mar 2025 13:48:37 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 883B940B94
 for <dev@dpdk.org>; Thu,  6 Mar 2025 22:09:19 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso1679736a91.0
 for <dev@dpdk.org>; Thu, 06 Mar 2025 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741295358; x=1741900158; darn=dpdk.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r0xrMbyIH1bjxAiqUX0E/ec6UO/fFY1yXq5hcLRYgKk=;
 b=nlVNc9mLQh7d8LukPE1HVOktI9lBDgjZ5A6l3Q1JPfInWG80hq7IFiAo2MqqhuoYfB
 ISY0Aaoa0NA+Ro1SLSwCoOMt/3TO06qLKiGOPWUFyjsQWfOLSFzwDBw8pVIJLLnoykBY
 m+bjUed2A4KAujIRffbAE2kZr28Fe3UxrQq4Kov4X5PRAWUOljSPx4Itkc0eiCPR+EJB
 pODEeubiF7nmkmRr6BDLRp4tefbkp4TItsWiKkou2UPZ13CYBbHSSr4LsCaTNcIuF5XO
 UNfWbWoXnG9WqWCU3vivocOEHkxxocSKQE+sX3i9k3GmY6zCp3NHz+3VrLNQsiEfW3aV
 TNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741295358; x=1741900158;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0xrMbyIH1bjxAiqUX0E/ec6UO/fFY1yXq5hcLRYgKk=;
 b=amrKH5Tz8pK3PkfX8awuzVkNnSrPoeU+TtBessepJSEvR7czwNb34Ljsw8bVH16a3m
 u+7YW8rS4wBN8zveSgKAo/v6MzXQVi/S4An+BiMISIzHlpUZ54qrBehLnCGJLd3Q2/8h
 gmyQgrxsFBvytvBCbuIjc36OtnTaSgXSG9qnexm4Jhj2tts/urSQPSxGxoxt3IUwlwRr
 Ye9zQpzb34qIf5YQkyUi/Ev/D7/j+OExfXkpz6lHMPLUuaEdbRf+PadUYJM2ZfDg+S63
 Y1uH582xkO2W6zKKGNmbFTQNeh/QTbF7RXri8lnMtWWNVE6sD1CS/JKwuuThbR0SO4sw
 rpBQ==
X-Gm-Message-State: AOJu0Yxl/nUxMq2iqtiRsA8fN1bW9O9+sjED45ftwYF7dcT7cmVpzEUj
 sRHNTUDW76f9L/+WNwEZO+TQio8ZSHa61WfOisGIipf/gXBXLhvmEVBA2JVMRtFogyX5tuuKNIa
 I/Bt/LQ3g0GLT1U5ELDr5plB9qNsbfg6N
X-Gm-Gg: ASbGncspqqBYqzebxPbD5dl1triWYdAF3+vlAJ6++C8o1v68Km/uzymgBiLtHXAsmoE
 vT9AampDcQ/YAr8Rq6q1BK3nNsMvVZSEjyNzOWFVzvE2+HXerrSZGj2HUVIqCeCub8y0aLGOwVw
 nma0X+2vmE20xyE2ib+TeXxGRUWyufsn2Hs3PepUEUyQDvV4hshwI8HSQ=
X-Google-Smtp-Source: AGHT+IGZVCSvkusVCb4w01+a3fEw2fZGeOXBPXIW0c9wSzZoCGsrKQHsl7Hinr/4FRnPHuoyNukTZJuoDmugcPGxxiI=
X-Received: by 2002:a17:90a:d450:b0:2ff:5ed8:83d0 with SMTP id
 98e67ed59e1d1-2ff7ce91ff0mr1359536a91.16.1741295358446; Thu, 06 Mar 2025
 13:09:18 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?SmFyb23DrXIgU21yxI1law==?= <4plague@gmail.com>
Date: Thu, 6 Mar 2025 22:09:08 +0100
X-Gm-Features: AQ5f1JoUy-hoziPCj7Og7aRTIMlK3gVEsTMb90e1O6ZBkfEnYugMz19u1jr2KT0
Message-ID: <CA++ArTjpo7QE5t4F0eevDsiuWtB_WN12FU9nxakxQ2a=nFxp5w@mail.gmail.com>
Subject: [PATCH v2] doc/guides: Mention needed kernel option for mlx5
To: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 09 Mar 2025 13:48:36 +0100
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

On some kernels (Debian 6.6, 6.9 and 6.10 tested),
there is a missing option for "TC recirculation"
that prevents MLX5 driver to include CONFIG_MLX5_CLS_ACT
in the compilation, thus preventing PF1
from properly working in multiport-eswitch mode.

Fixes: 11c73de9ef63 ("net/mlx5: probe multi-port E-Switch device")

v2:
- Added additional MLX5 kernel option
- Fixed patch formatting
- Added "Fixes" tag

Signed-off-by: Jarom=C3=ADr Smr=C4=8Dek <4plague@gmail.com>
---
 doc/guides/nics/mlx5.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 30c40f767b..06c6e80f83 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1713,7 +1713,7 @@ Supported HCAs:

 Supported mlx5 kernel modules versions:

-- Upstream Linux - from version 6.3.
+- Upstream Linux - from version 6.3. with CONFIG_NET_TC_SKB_EXT and
CONFIG_MLX5_CLS_ACT enabled
 - Modules packaged in MLNX_OFED - from version v23.04-0.5.3.3.

 Configuration
--
2.39.2
