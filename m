Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3505C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 14:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D16584028C;
	Wed, 30 Apr 2025 16:12:13 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id D3F5C40280
 for <dev@dpdk.org>; Wed, 30 Apr 2025 16:12:12 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so6209728b3a.3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746022331;
 x=1746627131; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=iNDkEOmQaeXNVFTQlxPyhJZm/UHGa9KaLH5Vq4SDXQU=;
 b=ZHNiwRjMo5TL1IfHlmOQ7KTnnnskftpC9jb5x6LgmCPGbuF+Ezqo/64MTu8IE/OVnU
 ZiHeRZg3zC9v+uNZ6WzMJOCgJ3gd21YJDQJD+UoLPULdnApvIYxin5oMOhaGBhald7N0
 z06VfaSwDrk8oaWzPuwmu4n9GAi6j9dXcIa/0fOt8021vjQDqn+PSOzUWFjZjQpmPYat
 vHjExXSa4+2hfhCCrkyJesyGWksDA1OC46+yrrS0fsKAc23qtzHdllGVlrdnqX4E2uHm
 tpMg+OwSa+fZW5bV5i46afQaoJCU8fWkOhSnoByCZP5wSdHbyz1cMS3t+VNWYFZVWbOD
 Gn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746022332; x=1746627132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNDkEOmQaeXNVFTQlxPyhJZm/UHGa9KaLH5Vq4SDXQU=;
 b=UofsI2EzYlytd8MIqhIs0HFcHmb4hWMJyVxSfAJE6fFIdYyDoP1wvCU8ZZCnR/MaDz
 R0HMfIhY3a5XOaubcEVV/h9rveuD1S3dMNdsgWHIt90uoKWLFPGC58/iHZLhqH1W0Bex
 PuBlhA7dlMIWPXY3DJBPFKqGPQLtWI9QF6PZQ55Aj3ittDAMxiEFIgK+zED2omXyNIPa
 wP70HPh8lSJ6221bEazMEmOE1HsMKnkKA+GDLdX4toSfmRIcC9C+l7g9WDEuewIMlQep
 G0EV3RTPZyBvWT4FaWVfzZSl445aF+Oa5LkuGyfgmO4Cy8smKIpk5DxSixyQ1+I1/Bmw
 L9og==
X-Gm-Message-State: AOJu0YwhxSmBqdB26DHaUsROB28NYHebnysx5jz8Wtwb6wuoxmfd1vL+
 zRkWqlZ/VzajXgh8MJSfdKeGRNl7m3/30eJXU65csjVY8utOlEqrstZggieM5wPNGDK/BMa0+Q9
 Q
X-Gm-Gg: ASbGncv02dBEwpqOudgOJuFEaPTROWkGkJWA4jI8FsdE5DbFQPOvgmnUOzeDSKMBZFK
 ZAmY2rAQFTolJKUHRJulQf7Q34WAcQ29vr/BHbTl8E210Oj8DhT9vaDVVhcU7DtuhkEIaYSWxV6
 QLbsn8m6bFCnE9P8tqX89e/IaSZVRA0PLxa7PHs0mDwOe7ndOlVWgeWOO0+hwHxI78EjkJJhZnk
 VoL5/mc/CzS11Q+ic7VD5Xr1kwulzg4zMQzCEHOrBexq2qrj+Cyv/YMFgDXUy5kZgDIpnsO6TD6
 E8Cyt+L6wWpi+xCdY47d4KSpEyAcqkH9j8exNA4CDSYClJ56SmrNpSI0JiqIZbLNqjDanX8S94v
 rfAyhriAwsfElpv7C
X-Google-Smtp-Source: AGHT+IHU/F5mcekc8ZMSG7MCPDU0QayGZj0o3uf3M74FlgSX8Kebl8dOTmPXQeCXlawjSla3dkUnWQ==
X-Received: by 2002:a05:6a21:6d87:b0:201:957a:b08a with SMTP id
 adf61e73a8af0-20a882347cfmr4099122637.21.1746022331538; 
 Wed, 30 Apr 2025 07:12:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7403994655dsm1659758b3a.82.2025.04.30.07.12.10
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:12:11 -0700 (PDT)
Date: Wed, 30 Apr 2025 07:12:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v4 2/2] drivers: add support for IB_BTH header for RSS
 in cnxk device
Message-ID: <20250430071208.6c514d65@hermes.local>
In-Reply-To: <20250430102011.991865-2-kirankumark@marvell.com>
References: <20250430091051.789240-1-kirankumark@marvell.com>
 <20250430102011.991865-1-kirankumark@marvell.com>
 <20250430102011.991865-2-kirankumark@marvell.com>
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

On Wed, 30 Apr 2025 15:50:11 +0530
<kirankumark@marvell.com> wrote:

> diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
> index a82d120d1d..030556c8dc 100644
> --- a/drivers/common/cnxk/roc_mbox.h
> +++ b/drivers/common/cnxk/roc_mbox.h
> @@ -1777,6 +1777,7 @@ struct nix_rss_flowkey_cfg {
>  #define FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
>  #define FLOW_KEY_TYPE_CUSTOM0	    BIT(19)
>  #define FLOW_KEY_TYPE_VLAN	    BIT(20)
> +#define FLOW_KEY_TYPE_ROCEV2 BIT(24)
>  #define FLOW_KEY_TYPE_L4_DST	    BIT(28)
>  #define FLOW_KEY_TYPE_L4_SRC	    BIT(29)
>  #define FLOW_KEY_TYPE_L3_DST	    BIT(30)

Why not use same indent as other code?

diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..251e48adab 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -1777,6 +1777,7 @@ struct nix_rss_flowkey_cfg {
 #define FLOW_KEY_TYPE_CH_LEN_90B    BIT(18)
 #define FLOW_KEY_TYPE_CUSTOM0	    BIT(19)
 #define FLOW_KEY_TYPE_VLAN	    BIT(20)
+#define FLOW_KEY_TYPE_ROCEV2	    BIT(24)
 #define FLOW_KEY_TYPE_L4_DST	    BIT(28)
 #define FLOW_KEY_TYPE_L4_SRC	    BIT(29)
 #define FLOW_KEY_TYPE_L3_DST	    BIT(30)
