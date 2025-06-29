Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD574C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 130C840612;
	Sun, 29 Jun 2025 19:44:25 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 47E7640288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:44:24 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d09ab17244so141497085a.0
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751219063;
 x=1751823863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Z/aA6Yrt76ok31yUCxjPqVgtnLdoDwYFt/1bGxFFQY=;
 b=qqAsL+nZxyA0IRWHfwQW/U9nzqKe0ifaDCmMgkk4w8J/KFC1rWhhFfN4btlwpUMXBW
 beN8HQ2rftePooYUye1TAhg1KJdSLpy11tpEFPRprDkiuhCc+gjGbSwTPY98NRr4RUy9
 MEPYGsYFyhvokW9THjKNrbbgRKdFHCihVMNK8hvXQnFgZaQbIm/T002Iu2M7EUnW9nTr
 2iIcIbCkj88L6WT2RfTMjkMGLILSx49zkVSrVwd1m1nKGkJ9fCWVelA18styCFX4Vnak
 XZEly31xJOgSV04g4Il2wosxdwoWhTce3mkGZeHGfXWOcYuR9nDdAW2XNyRCsYfGNtzl
 WNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751219063; x=1751823863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Z/aA6Yrt76ok31yUCxjPqVgtnLdoDwYFt/1bGxFFQY=;
 b=Gw0TrNLJknYqy6rPfTnpxhZLwJ4cxutE/x+k9yPh6TLaQfxqGp9nfoprc7egU1T16/
 ZX/e9bRMqmkYdb9bcidn7xr8VHCp+eRVFC/cnVAOUDo5K1PMgJHHOviBsjaOk7nz0RgN
 2dDzSC4uV6VEc29z87hAJKNCKgqjNlXGoFVA6P+rrW9YsRH3hA7im7DZxjmJLvB+cLGJ
 F1fXzXRRdYz37YH+ZeYyxegXsuwAZEq+eTJBHF0vKA9My4b8cGKvc2gRtt8tA15Y12fx
 E8fmQoKRFuMyyju1FGqv/0RuL7hyZ4DCWp2puH6s5v3ujQfQTDppsxO0dTaz9lK1AmnH
 ZwNA==
X-Gm-Message-State: AOJu0YylJ04kwgLfhZ9ZddYwasFUrZwpvDXFwO5MDoClHsr/lK8mU7Ma
 My3hAKz9UkW69fwNhFnqDZv5Jr9GxNFh1+Ldr+d6518eGdbTdN2k+LdXRSXyEOuCM9/THWJyeG0
 dxnneJ28=
X-Gm-Gg: ASbGncuIKBxeFsdDGw3KiXy+90cIyY9p7tdxKGtABLoQaIgyJPV2+3OQLj8xOfM9reb
 MHl6HoBcfdKycgKwCMg5s7kfYM6Zax6SpADpzmuUe7+pnDUObSTeBi1GKvlCgL8KtQgammIK/cT
 hZKx4w8coPApThhuR7pjDHwP2RdATNQRfymKE6yavEfuLmIIygolzDC4sC4hSltBqmaveWvzyd9
 I+3PY2rzyvbOxwnKYK2BQNLEHVdOePGOWoQeB+9HyeNLVdQph0vpvFc/0JCjiBH6U1hdwS6WTZ7
 ceFVRx7/wbGKfbhBiQxYSTLkVszdyvsB/uHeboVZN/iNqF3PnIBYllIxBEYy3APy/JuiOwPjvW6
 Ns2Ag1xjwENSqYb/pEdSRXv6jOHToKYUvUvfUe11B2H/MCDgm3g==
X-Google-Smtp-Source: AGHT+IG5wLduBJgr4bWcqLld/yUY7fW5/Q2Ir4FS+1HPoXxaF7Ae/GFy+rs8x1I/R9HsrVIjJjxJBQ==
X-Received: by 2002:ad4:5d49:0:b0:6fa:cc39:84 with SMTP id
 6a1803df08f44-70001e5be0dmr168136036d6.13.1751219063599; 
 Sun, 29 Jun 2025 10:44:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7718d8f2sm54803616d6.23.2025.06.29.10.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:44:23 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:44:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org, yaojun@mucse.com
Subject: Re: [PATCH v0 0/3] [v0]drivers/net fixed Coverity issue
Message-ID: <20250629104420.39505cf0@hermes.local>
In-Reply-To: <20250618121113.17302-1-caowenbo@mucse.com>
References: <20250618121113.17302-1-caowenbo@mucse.com>
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

On Wed, 18 Jun 2025 20:11:10 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> v1:
>   *:fixed compile issue
> v0:
>   *:fixed the below issue:
>   	Coverity issue: 468860,468866,468858
> 	Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
> 	Fixes: 52dfb84e14be ("net/rnp: add device init and uninit")
> 	Fixes: 52aae4ed4ffb ("net/rnp: add device capabilities")
>   *:fixed 64k tso
> 
> Wenbo Cao (3):
>   net/rnp: add check firmware respond info
>   net/rnp: fix Tunnel-TSO VLAN header untrusted loop bound
>   net/rnp: fix TSO segmentation for packets of 64KB
> 
>  drivers/net/rnp/base/rnp_fw_cmd.h |   1 +
>  drivers/net/rnp/base/rnp_mbx_fw.c |  15 +++-
>  drivers/net/rnp/rnp_ethdev.c      |  16 ++--
>  drivers/net/rnp/rnp_rxtx.c        | 118 +++++++++++++++++++++++-------
>  drivers/net/rnp/rnp_rxtx.h        |   1 +
>  5 files changed, 117 insertions(+), 34 deletions(-)
> 

Overall this patchset looks fine.
Could you try out the suggest bit changes, and resubmit please.
