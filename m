Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFA1C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:45:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6108E402DE;
	Tue, 22 Sep 2026 20:45:41 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 9D63140041
 for <dev@dpdk.org>; Tue, 22 Sep 2026 20:45:39 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd5cef0so163380a91.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790102739;
 x=1790707539; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b4RQgVwC911boud32C6Uzfrqqj+Wqzk1uVDUi7gvj0U=;
 b=ES8aNlfgpWYqR6pZ+/rNjODXmeOvto4ojyCE/ndi5crBB+W1W1Kii4k5N/Sh1cIgmX
 kzT5KIGWyTd3v7D7J0Z62zfDsRSS+ILwc/FXFKPFKOUP6Kp7kj7XYakc8ky67o2RyVCq
 SrNapoBvdu0iyhdMMW+gWOyjhROPJIJr7tT9UO3TN1BOJH0GxFNfsL6uFy2/lT3rtfdz
 P/8I50h2p1cTrV1VZN/N635iwBdzXu9XHhvT5HIto2lkHW3Fj+ORvUMinQqNrNbDBxUA
 zVBfjQ8qvfmkfJWmhJMOlgPfZvV6E+Aj8D5A+EtF+uXtcQJ1TOqBPupjDy0UQKTlsjhY
 OalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102739; x=1790707539;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b4RQgVwC911boud32C6Uzfrqqj+Wqzk1uVDUi7gvj0U=;
 b=XXK4WiJv83mlUm501o87bzIGtQVHM9YPPRvhX6gbNwCeiAOfIAF6xzKm7cTBCIbc2h
 LEV4mNC6i9dGIfogo6S5vTLyy3IjLRyog2gY5dC3jYFZX9THYVjlkp4blZ9DxvHnuG67
 x5zt8kQn8uENseK16ycTASx79iYyGW/xM9imZyjSTHfwbbrGJqHxgZqT6Ihi/3r1b1sm
 Aemc4WSMMSfvQrdHcE1KLPloO3D/IQf/8v2EYomfWQw54g9i+YFKtLyaZyu5Vyrz9d9D
 A+0XEpsbOfN2Rn+IajqPo3Aqm43fxq4TvCwK5idr0dnpDq8clxTUlE1yiCjlPzQSM6Lg
 8eVQ==
X-Gm-Message-State: AFuF++mhPJmtHXz80mH4wNqfZ2CBfkyRXT5w2EeRGPxIdYflONUbZoH6
 q8Q9o372w9roboZrawdhpFq05CluAxUyRfwoLQrDRNwsyVVFfrUhgtG0/En3avMh+iVtiiIoyYZ
 WS1R0
X-Gm-Gg: AYBFou0YGc01tvJOi5EENLKagZ/Tym4a9VKMCfXITpkqa8/DfqyyLAQyvWPY4aA2oQC
 L9lfopoQyfbipVRueuXsB5s386vwJCxRaxgwP1yv3Rl40keYx3UL4JSiVgPr2Tq1SD9IielXM23
 vQxYCIpBQ9T4dL235fup52/lWOSx+HdQq3EzTGySt2o6QeOhksyc2m2W0pMnfBOjC8AXwRqGueZ
 J2+eqFlhBlRyhntUoJ/R1DpIGTcVNKFjIRv3rjMZfSW62zKdgsSmhTxvtPOLks9CQHDwqxizqcO
 JbTNBZAIbuFK1Pi7EZ+q2oburOWqxxI7l+CwQPYvPIhG63zznA5j3kR65trpTAB+VTfyYolx2OZ
 gtb94qn9ivklYwVu8yJClkFJHiKOhnxcUMf/1IWNZryiPkl8PgquetPL5U80jczw6ge4tukhSP1
 Xh5I0SQvMA4Rtfnbhu8W5yowH3dVfQhMJXH2qC886RLHPuPt2OT4qOWje+0xlVQ+KcKbEYQuDNa
 APVdipQemS8rGC5cYVzkGhZvmV8EdfGugyNRSEC
X-Received: by 2002:a17:90b:2f04:b0:39e:6c69:f480 with SMTP id
 98e67ed59e1d1-3a07e7856bbmr295785a91.63.1790102738532; 
 Tue, 22 Sep 2026 11:45:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06cba762fsm1763853a91.4.2026.09.22.11.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 11:45:38 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:45:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
Message-ID: <20260922114535.450984dc@phoenix.local>
In-Reply-To: <20260920190007.1128720-1-stephen@networkplumber.org>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
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

On Sun, 20 Sep 2026 11:59:09 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This example adds RPCAP support over localhost TCP
> integrated with DPDK. It uses a secondary process that allows
> connections from using tcpdump defacto protocol rpcap.
> 
> See: doc/guides/sample_app_ug/rpcapd.rst for more info
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Recheck-request: rebase=main, iol-unit-arm64-testing
