Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B85606A327
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ccp0fLJi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAA0740682;
	Thu, 12 Nov 2026 15:56:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id AA968402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794495394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/vBUzCpFrE8cVrsNXtNfFQ92b+3CbY9fTaiSxg+pJM=;
 b=ccp0fLJiA0YAyZtCwnYG+fT/OLsF7MtXkp0EZR/6DhL/ehMFoSv9hMGJ+Upx3hFd5J0uT2
 wX4ivcoQphV8lIyI4MQVVhiJOKz1bVSVsUli9bbqoOmF7e+uiiKJHgban6jEAohsQeRbIM
 QbjKRkikX2b2Hu8Axukvc7udbCpLsS0=
X-MC-Rep: binary re single
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-MIV16QWFN12IG13MsyF00w-1; Thu, 12 Nov 2026 09:56:31 -0500
X-MC-Unique: MIV16QWFN12IG13MsyF00w-1
X-Mimecast-MFC-AGG-ID: MIV16QWFN12IG13MsyF00w_1794495390
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5c15976eecdso2078550e87.2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 06:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794495390; x=1795100190;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y/vBUzCpFrE8cVrsNXtNfFQ92b+3CbY9fTaiSxg+pJM=;
 b=Q2VxNZDRZx4QOAR5deJW9CCcMXSRJ9T9gSNQHvBGIrAVHeLxiAFtSRkYUwtnWR1EMq
 91AlxowvEkL4YWkmrCZOutblqYvE0yctuHpJIAb3OoHYnjoF7MVaHxwdymdiwrbHcpeL
 Dj5HHe/fOEYaNnDR4hJ+O25hJbLyNeGGGCoOwXSm243Mvw9oXGvTIE5eJZ3+7vE+l64t
 Bfp1tW9L4o+aHjLggacqlCh1MDmJ+RAQWhz+Fi44lTf0MSoHvQ8mP2RofExPbI7kI2iU
 n287tO5F1HejFIZ6d24qDypELnOJj0xztC2Xzl5yPYoLsFU/UY2wicPDqXoyD8OH9BN5
 gWNA==
X-Gm-Message-State: APuU4Z+srt468EFNn9o7Fjyto7AEGNBwPJcEJZhyWI3QY4BRob5tu1wW
 BHZ1DYXj9PXAiWRDBjpFGRbpKiEc6nEvFS/Bt+jSCamOLauTPVhSRBKh2N3Y7TpRYJxHMxH/t4l
 2LKhWWTJPlalYxsC/vu9QKPHrm2lfFRiwZkQoy40c96wndm1jQ24E90xZdUnhRjUxM4mh1jH5WG
 iBR9m0X74C/QZgvfZiLy4=
X-Gm-Gg: AYBFou3RXRiXvfPyMlpBObM9GHaIKd3bV2n18Sp7vOjwqXjdBY+u32gs/T7Xo1y69Mq
 w88sOool4y3Dp4IkN+I4d4r7RpbNvQxF7/th9DuSoYoP4ZtNqJMHwbH3DdQFjqT0s7FNua605jK
 ve+/Mg3JeLhvJBiXnVnGL0XnOrUnNb14GCDZW13oqcfU1GWquS8yX254ud+53IZyW6HzgYsyBhp
 729pFeCsJ/xpHK01MpCmtcNt8bNgJaKBcvhqPbEK8Fzh5TI
X-Received: by 2002:a05:6512:15a6:b0:5bf:b22f:19af with SMTP id
 2adb3069b0e04-5c15d62c409mr1936206e87.18.1794495390187; 
 Thu, 12 Nov 2026 06:56:30 -0800 (PST)
X-Received: by 2002:a05:6512:15a6:b0:5bf:b22f:19af with SMTP id
 2adb3069b0e04-5c15d62c409mr1936188e87.18.1794495389562; Thu, 12 Nov 2026
 06:56:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 12 Nov 2026 15:56:17 +0100
X-Gm-Features: AclHuK_bCFLfGobKZinYnpU4adcXcR06AJ5pUePkv-o9NWFaaNIZYpGp6aI0gnM
Message-ID: <CAJFAV8zCLw4rNFPwXng7hK4VXQ0Utw243Bafr8H1pgK019FeZw@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] raw/ntb: post-merge fixes
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, jingjing.wu@intel.com, 
 bhagyada.modali@amd.com, Selwin.Sebastian@amd.com, bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -RqPDGuvsiq-yVM9Sqfa6HJwC_6WkOTKPxGXCiy0MlI_1794495390
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 at 08:11, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series addresses the post-merge review of the AMD NTB support
> by Stephen. Some of the issues also exist in the Intel code and in
> released versions; those patches are tagged for stable.
>
> - Patches 1-4 fix the type confusion in rte_pmd_ntb_get_mem_align(),
>   the unbounded peer memory window count, the off-by-one in the
>   address remapping and the memory window leaks.
>
> - Patch 5 fixes the doorbell interrupts with vfio-pci: only MSI-X
>   vector 0 (DB0) was serviced, so the DB1/DB2 exchange of dev_stop
>   never completed and the stop waited for its 1s timeout.
>
> - Patch 7 removes the AMD hardware event handling, which could not run
>   as wired, and documents that hardware events are not handled.
>
> - Patches 8-9 fix the Rx path: a partially consumed packet was leaked
>   and desynchronized the ring, and an mbuf owned by the application
>   could be freed again on device stop.
>
> - Patches 14-16 fix the peer device status accesses between the
>   interrupt thread and the stop/data paths, and the missing checks and
>   leaks at queue setup.
>
> - The other patches are documentation and cleanup.
>
> The peer memory window size check suggested for the AMD handshake is
> not added: all the AMD scratchpads are in use, and the window limit
> register programmed with the local memzone length already bounds what
> the peer can reach.
>
> Tested with vfio-pci on two AMD EPYC Embedded hosts: handshake,
> file transfer, and stop/quit with DB1/DB2 exchange.
>
> ---
> Changes since v2:
> - Resent with proper threading: in v2, all the patches replied to the
>   v1 cover letter, so patchwork did not group them as a series and the
>   CI could not apply them. No change in patches 1-15, apart from the
>   rebase on current main.
> - Added patch 16 for the queue setup leaks reported by Stephen on v2.

There was again a hiccup with the CI on the v3, probably something
wrong in your mailing setup.

I had a look at the changes, and nothing looks out of place.
I ran my compilation checks, some GHA checks, all passed.


Thanks for the fixes.
Series applied.


-- 
David Marchand

