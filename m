Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2460E8B383
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 01:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 876DE4027F;
	Wed,  4 Feb 2026 02:39:51 +0100 (CET)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51]) by mails.dpdk.org (Postfix) with ESMTP id E9BD140275
 for <dev@dpdk.org>; Wed,  4 Feb 2026 02:39:49 +0100 (CET)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-948a2d37896so2393860241.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 17:39:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770169189; cv=none;
 d=google.com; s=arc-20240605;
 b=fqokyPUlZZ4m4zOPUTPAE3Pk7eHc5K8AM8aI2PVbHV/iMzuPqwAoNJ73ZxRiiks+Zz
 sBgM6RAGt102eTWEN5grzMUBnH2Q+6nMQPMtWtVIzgXqyIdIdRrqzttSEhkM/j2nCndf
 5szoOwwfc13SQDWNOKGhgoegUQSLH7nlXZNW3i6o/kLdKaVYU9+7BRujkL9qrl5GW8t6
 xtO/QJxb8Uwb1yrQv0Rmcein/6j0EY3iVovhBFIeHy90zBW4Y1/6E76ZEdzt08szLH3j
 3f8eAywWIk+VZuEYUALmfbdVVvLSDUs+CWkLEodCxaatq+pAN9Vt6YWKq5QBHFystN+Z
 wcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Mm98m3a4lZhJH7SKLV0MvZigLz6Rfe2RrpUnuV62IY=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=Cy8sz6Q6XKp1mkW7Sj5KDo8LqAhlMqBwiLjtKXOulveXoFjrDIMZyb1NPdw/rBDQ8v
 mdXRNCFCw6bwZ3uKLhLXTwymNc4rzvd9wKSPo3m9CeNBCuFpkpWIAG1f3lYMY7V9g5N4
 GyRcjenY+m6JIjTgVp5TYCsWYmyH4PWwgRepdxAaNsebTpeg7LmxfZw/ESYoWR4iZInN
 VLOZGZwHvWIdcu/Wou2Ud5qu0FK4GIbE/T+XZ+sq6EKdASK34xLdHMElnTMMR8eDFDdu
 xTyYJVRaKb7PBRIdfOd8n6A6VqY61O7IEu8GmHWrg3WBC3Rzex4H0actqxgLrg3IDIxr
 F4/w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770169189; x=1770773989; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Mm98m3a4lZhJH7SKLV0MvZigLz6Rfe2RrpUnuV62IY=;
 b=C8MHEBAyZIaET7odyr0h5PK5fDtb633FbXNR/bTY3eog0KioKU2ewiD+zg8dMWQTa8
 q/6CKAwa7sflLN5g0gJVW3/1AHm3lrf01hZg95KdQAXJwepCr41QzsYTIUiMeh9SLUIc
 Z6/igPj6MHTtG3SpSTVF6/YWvr3XfuYs24wr3Yb7NMMP8VlSPigAF1hSeovY+J+bJ/py
 IzHeh3c677CYrw7mHS47W0nwiJ3fUrtazN2he9E8aLFd0jAEiu3ehrAfMY0uMztoAwf1
 I5x9x/+cvA8GdZPASBBffj/KhbREird2cwt/eM+LWfx9aBnhjqHb78klqBeitK0n2xWH
 06+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169189; x=1770773989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Mm98m3a4lZhJH7SKLV0MvZigLz6Rfe2RrpUnuV62IY=;
 b=wItAUpHqHByvRYYvfNoeleTCuPaw6srbW9P3iZHNhYLz/9faPdTPVIfiSscD0sHvHv
 aZl16rIyTsxHo7PNm1ILkrgF/2Zj8eG5Y4dzoZyftTThJ328GdZMBdpFrz6sKMgpBY5h
 CeU7fFJ9wO8HiKXnLBeiYnzH5Q3dtgiVjpvwVpRWM6lJfD1nY+8XCNTmwR+9H74otS9t
 7lP4SysDUcWgOVq/09xdJoAY1VdmucRQlFxjZHLuqkYXf+wTXeJbepJw6cznM2OGD7TG
 ghrZ9JUEn1H6GQjpJe/a2LSLt8u+yhmIYKMP4khzRFkZ70me2t0RO1V1Hucj2ifb2A28
 GhEw==
X-Gm-Message-State: AOJu0YyLR/408E1gOGQFdhpe09gXeIaTG3ZWlUrArsse1+0/XVZBblDO
 umfOydpD82L4/oHF843mohafDpUK1hvH/Haek5YeHTL4KT/WkgH+OoGvJ74UpG4twrfmyoNfirG
 Qs64pDg7g8fbx2VlCGOBNGRNWLoBCZhI=
X-Gm-Gg: AZuq6aLdSTiwAxXwgQ9FIampFnzQ0m7y2fTmMg58curFDqDrGmmX2/ge4b+Hnx2+bvl
 vq3gVgmDDh4ZZopWmRVuhsJOhXig33frHZRapIEb8obXu+adqLxAXboRVvNwZXcAqMgWJ9g2Bjv
 Le18oib8QGeR14hZs4gs2ZL8Aeq81pV78QsLYQDfz95k8X824FoVmf7wZuK8McI5JXulPZhW9bh
 lCx756ZbsNvisG8dCr1Q67/EYL8pN6hn5lNQFw1oACaJJoPgyHTA99ChIhpbLTa8hCndwX61A==
X-Received: by 2002:a05:6102:94d:b0:5f7:2430:5340 with SMTP id
 ada2fe7eead31-5f9395ae988mr560555137.21.1770169189135; Tue, 03 Feb 2026
 17:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-5-scott.k.mitch1@gmail.com>
 <20260203061358.381ec977@phoenix.local>
In-Reply-To: <20260203061358.381ec977@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 3 Feb 2026 17:39:37 -0800
X-Gm-Features: AZwV_Qjjfcw2lDKdCvHkC0p4EGcWqFeVBhQiKvWKgHudw5HyD_TupFqGy8e6-Gg
Message-ID: <CAFn2buCpy6C+ahAcM6mNUjdJL33YVgUHy_5AFxE4V6HjRffL0Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] net/af_packet: add software checksum offload
 support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> Probably need to add EXPERIMENTAL into docbook comment as well.

Done.
