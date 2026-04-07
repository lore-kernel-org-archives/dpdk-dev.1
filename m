Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E9FF5104
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4D9F40265;
	Tue,  7 Apr 2026 17:12:30 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id CD0864025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:12:28 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso5562540eec.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775574748;
 x=1776179548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gx3u7Z4uXeRNOhlO1Aix1/hbVAUOLRmSO1vG5nK7+ec=;
 b=cyYBIdRBBX3odGx6eIJu5lhRAeR5a2n4zSXlI5iyFm7vrRouqCeJwNVjNQ8KLjsrvO
 X0KxdZh7iUUHFyRRogyliMV8crvXfHz3gvBCwmyw8CpjZKLVbttpJlT94oOfFvd55P/U
 dQdysiTNXw2R9ekG8zT0wtZNI4nORzwCTBigyzQs6UrVnuYyDxwcbztjMiZpKZHC3W28
 URFromYeregke4sAgmZW6ZiKHuEAHuhvLLGtxUoLcgrGw7MQaFfTZA+voF/vH4BSpb2f
 KTo4NBjvEvaxgOvUpLJ/OZ1jlR1tECXOw+dIu+WFoAlCeNMD1ik2FlGQ6X2RX4Vd7Dfi
 x8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775574748; x=1776179548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gx3u7Z4uXeRNOhlO1Aix1/hbVAUOLRmSO1vG5nK7+ec=;
 b=RsMNtwvf5d8PQZs7rLj+isNTQURSyMiR+hCftc7A4AVn2TBwbJnHIrDqeORFpDPkDh
 YVFxYCLxZWBBsOigcorknuPnfYFz0rfH/tm6nSoT0GZgDyP54ZFsAeEZLzdQA6UVt5A3
 k4BIdf3xmnm0a77e27ghJvfghBqBE8+VCXQzhiuQCGKWgm9x3ItkXFq/JaQ8J4aeKXxD
 VDU9NcC2BRNbJDTaRj48jLGeOJRwVenZlBoC4x5qOzWSzjoDYPTsWVIGwNtTsHnBvjtj
 rYINXfdBrErwhBwujNo7MeN4+D74fPybgLf90tLsseC/M4c9lAr0Jm1iDPKVxlA0yGfr
 mEcw==
X-Gm-Message-State: AOJu0Yxhblri6hZgN/HSYKcSozH3IG3Pl27UZ7Sy5Dvt94URAN/r5qaI
 FoaFbOxcxgb6yay7NgKbG4FPei0nnPyzevAFnReTnBaox5iM/9C3fGSr0lDSYh4WVRo=
X-Gm-Gg: AeBDievRNagJIHmL0EJm2WNDC0QL1WEqnj3rSOJIpVNQiXaGrCtbkHZ8PyzCya+WXiC
 wfrzRTI1UZDHIF9aIM73oTIxjSOQQt0j0gO8nw2dt8v+dI+xtJ1//lwU6MReYNlseDbA15FYngA
 S37Vl0212VY1K+tA+fljCFAOByQ+/hiPtD0yb28xBNTib7syjmSJ/AemF+P82vkG2tNkYgsW3WN
 zcZdIyZJSDPfAfSLlTrTb06/BeP64Jtsaf7fQDsaflDxY3aZUTM77i2Qq2Ar0uZS/jQAGXG1Ejd
 8ONkjpDqF/YcF84ShV/ZItwr44vdSoDPWlP6iVNFBdQMkkaIG6jUO8MeaVndYmRPn4L8+ht30Li
 Rpopi3g6bgzqHmVL0KF6mvYmdRgq0LJLpguSCG6mSsu29oXUKFuucfbZ5xbj/OxLpSRom9x5CLi
 kmiZTvMqlDJB7vbdQ3NWEsctLZhza8ZSrtHYUEDaenDzwVUg==
X-Received: by 2002:a05:7300:bc0c:b0:2c0:c767:b65 with SMTP id
 5a478bee46e88-2cbfa4c470fmr8848151eec.15.1775574747655; 
 Tue, 07 Apr 2026 08:12:27 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d11a96398asm4203004eec.28.2026.04.07.08.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:12:27 -0700 (PDT)
Date: Tue, 7 Apr 2026 08:12:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/7] Rework device probing
Message-ID: <20260407081223.1c0b8f1d@phoenix.local>
In-Reply-To: <20260407115211.1903623-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
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

On Tue,  7 Apr 2026 13:52:03 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Applications relying on device hotplug don't work well with the default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.
>=20
>=20

Series-acked-by: Stephen Hemminger <stephen@networkplumber.org>

AI spotted one minor nit.
Patch 1/7 (devtools: check packet forwarding in null test) - clean.=20
Minor style nit: the first grep uses $build/test-null.log while
the next two use $logfile =E2=80=94 they're the same path but inconsistent.=
=20
