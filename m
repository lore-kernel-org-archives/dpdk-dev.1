Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245C606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zg1mkR7A
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3240140276;
	Fri, 23 Oct 2026 16:37:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2183E40276
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792766265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SENMRb0OU571mVUTIc1aHfEINgIqSdmAAnC/HUe2X0s=;
 b=Zg1mkR7Aa4P8gPhiojhLeI5/p7YSUEAD/gSCWEJ6vpp6WCDBaZQvJMf32HAV1W7cnSGqxF
 wJ4BGT8RMz7Unwycqh5ISPqZS+iLt7guCMoRCDHBX8vxTuRx1tZC6euLqclb16uN+dtmEx
 fXDksKDuspaykNRcbHp0MFv8YFSX1Kc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-l3KrCPTXNM6B0W8XlpYKRQ-1; Fri, 23 Oct 2026 10:37:44 -0400
X-MC-Unique: l3KrCPTXNM6B0W8XlpYKRQ-1
X-Mimecast-MFC-AGG-ID: l3KrCPTXNM6B0W8XlpYKRQ_1792766263
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5ba3b187b35so724881e87.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 07:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766262; x=1793371062;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SENMRb0OU571mVUTIc1aHfEINgIqSdmAAnC/HUe2X0s=;
 b=IubLrTkWUBDMFYUiOCRu5LIi7przAsVuM1H2IeOIKv86qHmyDPjuTFcoW1PhqVsQSy
 dSa5k7iKW1/k7lIE41OBbsuvqx7DyrgjR4hFSZTiw7PGByfPd/PPz+bH72GQzgtX03kB
 FemkkEk72dJsx07NbrwvYFTjrPR/CTcNglvgKES9iJSvsbth5a4gd0XZsIRcgzpeedBM
 z9N34VZ7olPRkjaMVHZuiXzUXHJXxiINnj5HVEMQ/Q7zJs7wPCyDu+nPSdV9Bogs1H25
 KhbnL56XO5mLNJ3zil+gpLG/qWdiv4HL4H8/yOX5o2LCDWwe4/4zE4xuKH4QddCdOFO3
 /tuQ==
X-Gm-Message-State: AFq9FYKCiZcT0UkXbEOJ8J6hT4jQ4Donn9B1Zi/UXH8jihByaChCyZBh
 v/t34I0zgPdY1RrPElk4b7ynYgIQ2N2/Ms7YgqLvPuEAY8sGAQnDAuPuG2xT/OYBbrLA1xfJDlm
 /0VdC290/pW+qveYmZJJJPhEUFKGrtje5hJPDLCcU24ODpBdj3N3kI5oCxpA/dNSdh5daHCBg3o
 1MY6y5EatFxpYTY8kV+cU=
X-Gm-Gg: AYBFou2tSRTFOQEWJJE8KTR90ubUOiB9PZ4rlRrFfdq3cP8e6eE9cpixkY6SPy2GPNl
 Bi2RFMO28edufA6Zr+Ok2nW7xCH7oXzrHSofaLLOtsFDKKi2Km/CyBaCTuPMA8zedxr1EC2d2+T
 LtFnGaEX3vbjBLt3bkR6WhucAWK5KShue2dRR7EomkRRMMl42gtzMGNsDSfDJu1uD0HGKzq08/D
 8qM3bLii542Do++CcE7sdA2JQ45+IPtf5/b5h16qaeBds1/
X-Received: by 2002:a05:6512:694:b0:5bf:a172:db47 with SMTP id
 2adb3069b0e04-5bfb0b24807mr811918e87.16.1792766262451; 
 Fri, 23 Oct 2026 07:37:42 -0700 (PDT)
X-Received: by 2002:a05:6512:694:b0:5bf:a172:db47 with SMTP id
 2adb3069b0e04-5bfb0b24807mr811913e87.16.1792766261988; Fri, 23 Oct 2026
 07:37:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <dd9dcea6504722fc56aad5e1789755ca5f9732db.1792763492.git.anatoly.burakov@intel.com>
In-Reply-To: <dd9dcea6504722fc56aad5e1789755ca5f9732db.1792763492.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 16:37:30 +0200
X-Gm-Features: AclHuK8lUUw4T5f4DUe-gx0dgeMARuGBM4uj_ehpfzDeLXHdLo9Zma2AmYOGWmI
Message-ID: <CAJFAV8z7SkG2z4wB6Gcb+JpAVm8XnkMMy3w1+bS7XFxxdxoCCQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] eal/linux: fix eventfd leaks when enabling
 interrupts
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>, 
 Cunming Liang <cunming.liang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XGjuQi2RWqP0ZdoxJKEOFnWMCIYiTyXrZwc4lOywV6o_1792766263
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 15:52, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> When enabling MSI-X eventfds, a failure after creating some descriptors
> leaves them open. The eventfd count is recorded only after all allocations
> succeed, so disabling eventfds cannot clean up a partial allocation.
>
> Calling enable again without disabling first also leaks descriptors by
> overwriting the existing eventfd entries.
>
> Reject repeated MSI-X enable calls with EBUSY before modifying the handle.
> Update the eventfd count as each descriptor is created, so that on failure
> every eventfd created by the call can be closed, its entry cleared, and the
> count reset.
>
> Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

There is a type change between the two loops, but that's harmless.

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

