Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC56BCA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72881402F0;
	Mon, 28 Sep 2026 19:56:57 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3137A40275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 19:56:56 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db1ca069c8so14891385ad.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790618215;
 x=1791223015; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jhqruIiyXiqqUP1aD9287iWNo8noBfTdCrRsSlBnVc4=;
 b=gE/8Hl/nLwOd0cE4n+AiZfw5LBd3X1iRjrR8JRmFmtXDXr8GmkcIVRLBPvrF130ppp
 zsySmY/lYusnU0u/B2ixpCY089BUXSFWdg05LQEVeJkuRx/ASZWXTw/Af+AztiR59dJU
 wIaeDm2ZXU1BHVhcG/BylKkO3mjvHggT3DZyPw3lTodo5n4bhmKdTNpP4GNvEJjF3vKk
 CdqPdtNE6973lLC6MrTKyKSOSzLz2epefuuyNnbA+wXDszYksqlionsUFZMObFzqMT9s
 fbsN90vEB/W2vgBVobi95hikTu6tTHro4vbam94qFKFRqeK6OkQENvQKpTj1z9/cBJ8c
 6ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618215; x=1791223015;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jhqruIiyXiqqUP1aD9287iWNo8noBfTdCrRsSlBnVc4=;
 b=xJsq+RdWLnyYUQpF3RBh3UEEzmHRmxfDOZAKBO4KRvWZrVParQZ8LQarti4kjxSze2
 ae8wSCtfaMRESym4ukhdMkAP3J7n80zIs7eQyUHH0sP5RiSHoBbKkyZY41YS5gAjTDPG
 ISNm5Vgf54G9sWBb4U6gy5fKPXa9omWkGE3UpaRblZ1VaqIdlL/oWU9BVCjJSViGqq0A
 13bz+PQ/1IYM2WjCbFKnICAGFzzvMGzU5tcvogaTLu/edViQMq3tJV8H6X/XbrCkqV9o
 v9c01RyXxflYcvvpUwljJfjqsF/+wtNCK+4UNArZrH7JJ5jCxdrs5Zz8NQqc4TENt8pI
 8/mQ==
X-Gm-Message-State: AFq9FYJBPBEaG01Nz3VuOIV4tzWh9wF/5BmLb+DuAAsNwpIPUPcmse9q
 7O9dJEjLRFPhf/LKR6Uvff+zu8KxRuyjtZYxX4BoleP+cyziJEeFuM6ii3kVzIv/yrzpHnc+rP0
 JWUqcIc4=
X-Gm-Gg: AYBFou2fZdjBPNmJKCpiP/OZR2TFwT2r9+JqJGgwH0Mj1nIxWKjouBqq/ne9nxd0Ryq
 suWmnw0zxplJECMdzFvch4ejal9vza8Uq5ej7RZ6YasmhYEV2bo++EIoZBcqRemGZdOFj1c3ulm
 qobdHp++mRUKDJqyD0gE4oY62RXO8VyUsdFzKu3+ralP3FLYTVLwBkcYQDvk5iBx4wBlJj951lz
 z+LswGftD58Y0EfBKHbqjFHE0kzWTVXTy2mipy6JgXS0rlcPgMfhiujzpyyn4x9zqP2AjzP44oX
 Lq4LvzxshvIqeJ0etzRvImVa36ZYlsquPel8SmMANMkz9FSdgOIuHNMMIwGm/+c7y9qNjdiidJ8
 zvAODrG6BgHA3wigHdMmSNJL3MVZo3wuVitDkuw3GlOrN30kBeSMuvXf2t3Pg/dpzPp8Mij/KLT
 fYYRj5c/xPA1gbIQ0ramyQ5zDS6tqnK6kSey/NKlnsUufFEx1IK7zp/GQsNdVyK+ypkrDTUHyGB
 MUTH/C3RrbdSOg6SlTSeE2z83Eo9wv7iiDxl2kK
X-Received: by 2002:a17:903:240d:b0:2df:9fac:c26f with SMTP id
 d9443c01a7336-2df9facc301mr66578535ad.50.1790618215002; 
 Mon, 28 Sep 2026 10:56:55 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df913de18asm46065585ad.26.2026.09.28.10.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:56:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:56:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jakub Grajciar
 <jgrajcia@cisco.com>
Subject: Re: [PATCH 7/7] doc: clarify memif secret is not access control
Message-ID: <20260928105653.1b8443e9@phoenix.local>
In-Reply-To: <20260922194138.508919-8-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
 <20260922194138.508919-8-stephen@networkplumber.org>
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

On Tue, 22 Sep 2026 12:40:58 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The secret option was described as a security option, which invites
> using it as one. It is sent in cleartext in the connection request,
> and when passed as a device argument it is visible to other local
> users in the process arguments.
> 
> Describe it as what it is, a check against connecting mismatched
> interfaces, and document what actually restricts access to an
> interface. By default the control socket is in the abstract
> namespace and has no filesystem entry to own or permission. Only
> with socket-abstract=no do file permissions and the owner-uid and
> owner-gid options apply.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Tested-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---

Recheck-request: aws-unit-testing
