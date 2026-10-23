Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240B606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KaUzJYgH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B258040268;
	Fri, 23 Oct 2026 16:17:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 711B040265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 16:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792765066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=buK/fGzqfaJvwF2njfXsk0D1DDr+Dl4LxiT/eqH8eyw=;
 b=KaUzJYgHsa7VlQnbD3wKBQdGA8OCrLsX7swJQzVVkai/QZhZvOY5oRZFPGyT7fNuKiwV2w
 dyH+3Jn+aF3BkjxST6r1QUjCUfgVT+kczCc4A2aJxshV3SmFHhGoidJ5rYUG8Jh8g6KD9d
 ra4dg3s3ISEW6q3pXcdDcIgxtpzPoNA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-rxCrVUjkN2uZA1Ippal32A-1; Fri, 23 Oct 2026 10:17:45 -0400
X-MC-Unique: rxCrVUjkN2uZA1Ippal32A-1
X-Mimecast-MFC-AGG-ID: rxCrVUjkN2uZA1Ippal32A_1792765064
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab353585f1so4472811fa.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 07:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792765064; x=1793369864;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=buK/fGzqfaJvwF2njfXsk0D1DDr+Dl4LxiT/eqH8eyw=;
 b=r7XyWju2AWNFCJF3UqwaiE9dLZJqtc9Okrd3aIfjHf+76/Ld5WMCyTzhV+86kbQpB0
 /P+EXpYYTtk1HTgSZUcX/IVpRQC2n3h/Ybv2mUFrhDKRT7IoVi237EW6Y/0h8fYPLGvu
 FHNnVdYFjBlGdPNgGiaT7BHDEbSOK+p8H30afYNdPnqTPLcF7dE4oQYgBrs/eLoOCa5l
 GevUnK/XdmwQt6DVS4hw8bsZXkVnU9DRwSQ3x/SYYX7zIib9ep/BCyKhBT9a3bOjnbc+
 IKeyWQ/jBdWO9huM8OXkDOGWSQF4ji2hnKoV5+l2ajFrrx1u2WNY63CSsk1Jr9pwiYIz
 pUIg==
X-Gm-Message-State: AFq9FYLr+/rbTrAGEOQ7xAY0v1RN6ty1/uzTbAG6MhajH4M64TCl/bGE
 QWEGXhBq8wa3IPmvjM5l74JZAHeWifzb4ipXxNY3uSr4LiV9Vmiiii0SpD/DYb3Y5Og2T9KhdMz
 9khWgIZYjvVn7W1X69/ao8UGHQs2YtM0SWWoGnZFRAAmP2/87vQDgrodPA3uqO+5lPmgoNSjdzp
 IkLImaP8SQ4YqgObp6BwE=
X-Gm-Gg: AYBFou05Q+SWJIQYIZKubjqdDYp3DzRTahgenGRg9DJKKkcv4yalgyj8pfhmeJxEGPJ
 8CxoSWUM9UdgPUCZgwjo4R+j3msKR+TXw2RV18vIde6pF3GDhxqZkAawHOcHvWlhH2UY0NH/Mul
 x/g4lMfqe69vZMAC1/XzW5clHVOefdZluh5POtdLnrK/AF446x6E4NlXdVD382iyvm35Xo3ZB5h
 jrf4iWsTa5EJEEd0PzmnOq1vP2Ff9C2ynVQauPU45ydxvl+
X-Received: by 2002:a2e:bc1b:0:b0:3ab:690f:829f with SMTP id
 38308e7fff4ca-3ac6637c6efmr5404871fa.15.1792765063946; 
 Fri, 23 Oct 2026 07:17:43 -0700 (PDT)
X-Received: by 2002:a2e:bc1b:0:b0:3ab:690f:829f with SMTP id
 38308e7fff4ca-3ac6637c6efmr5404801fa.15.1792765063556; Fri, 23 Oct 2026
 07:17:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5766e02ea3243de1f63eb68efc210719f11815b6.1792763492.git.anatoly.burakov@intel.com>
 <61924e76b67043fb4b19c09bc60acd00ad26681d.1792763492.git.anatoly.burakov@intel.com>
In-Reply-To: <61924e76b67043fb4b19c09bc60acd00ad26681d.1792763492.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 16:17:31 +0200
X-Gm-Features: AclHuK_TYrBRy2QMocucL5_mQ_hS3lULcziGmTf7qlqFpzRdHIsEi0XzYl_6j6k
Message-ID: <CAJFAV8xnDXmO_S11sqWTW6-s_FG3eUg8=a2BL8b0RgMoVmqaHg@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] eal/linux: fix closing of event FDs not owned by
 EAL
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>, 
 Cunming Liang <cunming.liang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bKGVsrsi_VEyOM9wX2WkJKCw0wxGxdILjMBncevjZfw_1792765064
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
> rte_intr_efd_disable() decides whether to close the event FDs based on
> max_intr being greater than nb_efd. This is a side effect of how
> rte_intr_efd_enable() fills the handle for VFIO MSI-X, where an extra
> slot is reserved for the misc interrupt, and only indirectly identifies
> the eventfds that EAL created itself.
>
> Any driver filling the event FD array for a VDEV or EXT handle and
> setting max_intr the same way gets its descriptors closed by EAL even
> though it owns them. The virtio-user driver does exactly this, so its
> callfds are closed by rte_intr_efd_disable() and then closed again by
> the driver on uninit.
>
> Check the interrupt handle type instead, so that only the eventfds
> created by rte_intr_efd_enable() for VFIO MSI-X are closed.
>
> Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

LGTM.
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

