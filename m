Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C8606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fzxh/XZp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58058402BF;
	Tue, 17 Nov 2026 18:25:31 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 9A9EC402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:25:29 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso77757a12.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794936328;
 x=1795541128; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fkaend5Ndifb6BrF3qBAzZZ02jqYRStRto7tx3ivObY=;
 b=fzxh/XZpAQteNwtAVuhp96RIBZnER/9mXMNNoGP6Du1v5XsvAYyJA0cHoBGGEfhuhr
 psFXgcy/Ph4GLxn+7ExGLOCYXZ/wWVt/Ofu5bmjWjB8pXCsoNQrfLZFeHZsqYtYMUWyD
 b9YXsjehqU5ntx2fYF71+xOvBHpnKjYu9nloOZVhkz8WzJnWeaUl1U6xnzjBMLgK9a3H
 gAxljqC2ycIc33h96tJklwq2e8iM9vdUzEKj7I2bebIvvhiQG7pvS0aaANQESHIR63mK
 pNIJl14qOHzPEBFXz1KgvkH0vKTS0elNMAbG0aDgdIDve0xGwHf4PhnkO04EA6EkebIR
 B6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936328; x=1795541128;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fkaend5Ndifb6BrF3qBAzZZ02jqYRStRto7tx3ivObY=;
 b=0p47aQCiyt1PdkaKedBDZ45lGM2k8CDiQKGiyYW7sua8co4NyP0ONM+9VlApHv3AO+
 mnbzSgr1eMAhWkJxACBIr+PWLGKdT9ANZM/xSzIoHGth7lF+nGKhkwROVYfutSkEC1C2
 BSDmnN3sUMRe8bWL3cLE/KJqfwRuTo/uAZrq7z9b+zvlEG9czCStFSkuzq26qQqA5MZn
 EnVPaDeacJ8zCd4cTJQfWmiqqPuehV4GvJQtGCTsGT7JeG2sTknZheRKP2eSQCTuh71r
 QnDKrIsBAUBGmWcjvJJl3/0zCWZs88+o4e4jW6KDKrBN6vi7lCqiCt0xqat1Cqc0zjU7
 PQWQ==
X-Gm-Message-State: APuU4Z9rx5f9izLHYjYYzsTyzS49lYVCz2RbFl2kAfyhboui8hq1qH6k
 ZLgU8ubtP7XFlwQUPP2GrreIkmiBAjq+P5UUuWpRYF/EfLYHxksWnqi18GPCouY9Dkc=
X-Gm-Gg: AZFdTZfAEDj4tYAIv/aebC4uYhFNX0VogAOTfv4R4qlOsER1sDJsDyclpTFPJF4I52x
 yGKUDNHhWwU8jscS6VA0I9qpdBAkifPzFUMzSOotfeIvKv7r1AAcrkeTsCXEXrTVIbcEaU7/vBj
 dMXAF3DYbfQFDGDMPMqCyhFJwdrSdZdjgp5RntO8eWUegip+737kf8rzZOeCN1S8jidZvxzB2TW
 agZQX/DlDuDEO/wA57FpXokmlJEFszhEa8nPomBAnOhh0PRZn5ASiTet6ihoHiibq2EKZisMpMH
 DuziTRVjEimIuzl5JIF5JuFiYRS/SJn1SzmT3sQIew1ld0SuW2vVJHAQz9KaFhGYyBq4cn1gPCO
 AWAffm2MK2KCdn2E9FGwqFCUUjaR/VtRbgRT40eLk0urQX+yxU0Ds33lrqA9BgIlFGDyK7axg41
 CxWO5GrWtfYnToVtwIrNCArYW3QLGXq9yUFa/zhtAKN5+0BSEwhghohdrFibuleMrOp2C7Y8pI6
 tFF+mHtPi7OgXHG35KXfJArrtf9C6ZBsbDh9s9h18x5FKvlsA/Ne67TMeTAAR98/LVrk2tDLjFN
 FZOmeHEwd/MEmx38sgR1c/zsiPQHSxo/obZWbBaZUCmcYNdWSKM9AN9zJvaTK4+U61Jrcg//Qg=
 =
X-Received: by 2002:a17:90b:1a8a:b0:3b0:a3eb:759d with SMTP id
 98e67ed59e1d1-3b3d07a2098mr106931a91.10.1794936327896; 
 Tue, 17 Nov 2026 09:25:27 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abb786f7sm4948285a91.1.2026.11.17.09.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:25:27 -0800 (PST)
Date: Tue, 17 Nov 2026 09:25:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v5 0/4] DPAA driver changes
Message-ID: <20261117092523.4e08f57c@phoenix.local>
In-Reply-To: <20261117054558.1297266-1-g.singh@nxp.com>
References: <20261116062512.726405-1-g.singh@nxp.com>
 <20261117054558.1297266-1-g.singh@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 11:15:54 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V5-Changes:
>  - Added a reset FQ helper as per the AI suggestion
>  - Fixed the portid issue.
>  - Added explicit padding, uint8_t, size checks. The version ioctl is
>    not avilable in CDX module as of now, so mismatch module will fails
>    at probe only through existing ioctl errors.
>  - Fixed stale FQs run at close issue.
>  - Added a AI suggested warning.
>  - The scan moved to probe, close no longer scans. A single combined pass
>    would need the Tx CGRIDs before the Rx CGRs are created and a scan that
>    takes two ranges, which is too big for this series and saves
>    only one scan per port at startup.

Applied to next-net for 27.03
