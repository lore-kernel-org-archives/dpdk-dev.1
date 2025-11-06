Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E535DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E73CA40E17;
	Thu,  6 Nov 2025 08:28:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D80B4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:28:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762414134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eFpom0u6AIg3pRMSUXP6l3J1SVQQNthbms7XxtjbRs=;
 b=HO6dT8FwgDt1ksyrZPFXbjBuUvrditKlNzdylnCpMLTUnHJHQit+3UBTm1DBof5PtwfBZu
 3wAAAVHJiY1yt4nhKO59exHqjjeLRcvRzjLFPIWKEK/kmlX0GNfljMX1QuKj9q8ZyrKybh
 /EtBj7I7zkLK6lA4bWQt1+nXtZ+AQRo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-P-GFcdQ_M_6__FQYWINeZw-1; Thu, 06 Nov 2025 02:28:50 -0500
X-MC-Unique: P-GFcdQ_M_6__FQYWINeZw-1
X-Mimecast-MFC-AGG-ID: P-GFcdQ_M_6__FQYWINeZw_1762414129
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-594302e1f44so334191e87.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 23:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762414129; x=1763018929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1eFpom0u6AIg3pRMSUXP6l3J1SVQQNthbms7XxtjbRs=;
 b=urwVlSxyiHiU50WgPMBUPA4Szs3PN1wJVIPTQ+WSL43N40I5M7I7sLT9k61HRWlj5x
 UueEM1wmoz4Mwp1tw9zkB8UgZ4/FYdGO4snKWMSO012N5OKrw+1kT80VV9wGSjnlf1vO
 IjPGJYpADtooUw1Wg1ApSkjadYpp8/0CQiTQBpV27T3HXzGYGQ7+Fbk3homSRUIp5ng5
 Q8Yplj3T33aJ7ET285DYoEhvhVKHMaHgabaTbHu3aVXj/5bObxIGRedAVBGMx6XKOvLC
 5uutYO9h5G54LY3auYIlsFqIHY+WFE+5uyRcpxO1GuA8xab39NBvu1RZqynNXAEWkchV
 jbwQ==
X-Gm-Message-State: AOJu0YzJhSEUtlwL2BLmao7MhzwrFN/Qjqjs2zLEvcTKnideFdgAJcP0
 B+STk0Q3LsCpLJUx/7oYItUqE4jhw/2w3Pqf68zzlzNJigWx0+7F02DxWMtVD3MYa7ELUhBBk4T
 4HQhXf+nvB05A7eIZ3jgWfxY1gsxhwPltUlauWWVc5ky4X2pVphcmo1cPWI9uFASZzjLqNZ3KvL
 UqC+G3BJCzgSE/zeZb29w=
X-Gm-Gg: ASbGncsqv6xh5GlRVnePIgZOAXTUoTJBW2FfEW+CmpB1bEAxxZynbaTfAXw79h99SFH
 OoHqm4ugnPN5PW947YKAz5cULG07jjovxbQoFJk0i5wMmfy8lEVaLDI7NyNYoIujX4QLAjcHq2k
 CibQM+X0wx27nIxZ3aue/1VMP+9vhOBPJfq+Wr7Z1iaLTFOQETJFsVIp1dLw==
X-Received: by 2002:a05:6512:3a86:b0:594:27c6:a03 with SMTP id
 2adb3069b0e04-5943d74d4d0mr1997095e87.13.1762414129299; 
 Wed, 05 Nov 2025 23:28:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9cWcFHLJQUfLE3rEx3pS9tV4SAgRWXOYhmQyOb+MjcFA+xnpQ+ekUX2e2GJ2RCDUyPGmds+PgeNeLc3CK+RM=
X-Received: by 2002:a05:6512:3a86:b0:594:27c6:a03 with SMTP id
 2adb3069b0e04-5943d74d4d0mr1997084e87.13.1762414128871; Wed, 05 Nov 2025
 23:28:48 -0800 (PST)
MIME-Version: 1.0
References: <eb2c322e42a39e684514186503515e96633cd991.1761041388.git.anatoly.burakov@intel.com>
 <7e195ed0245a80a7f3302ae5d3c08a66c206ca9b.1761052774.git.anatoly.burakov@intel.com>
In-Reply-To: <7e195ed0245a80a7f3302ae5d3c08a66c206ca9b.1761052774.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 6 Nov 2025 08:28:37 +0100
X-Gm-Features: AWmQ_bl9HQziBGF34tbkQGDmWpGnoQRn0aMkO4AmSals_5VPta20T_U5ZpCOyL8
Message-ID: <CAJFAV8zSLEayfO2NPFmTs3Ljq1du1o0f6iuFvcaTM9BT1Ge-nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vfio: fix custom containers in multiprocess
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Xiao Wang <xiao.w.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Junjie Chen <junjie.j.chen@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e-7zmseZ3K-2DtAlSMbX7CMfYrA5qi9KecmmlfG-okk_1762414129
X-Mimecast-Originator: redhat.com
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

Hello Anatoly,

On Tue, 21 Oct 2025 at 15:20, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> Currently, the API regarding handling custom (non-default) containers has
> a problem with how it behaves in secondary process. The expected flow for
> using custom containers is to:
>
> 1) create a new container using rte_vfio_container_create()
> 2) look up IOMMU group with rte_vfio_get_group_num()
> 3) bind group to that container using rte_vfio_group_bind()
> 4) setup device with rte_vfio_setup_device()
>
> When called from secondary process, rte_vfio_container_create() will check
> if there's space in local VFIO config, and if there is, it will call
> rte_vfio_get_container_fd() which, in secondary process, will call into a
> multiprocess code to request primary process to open container fd, and then
> pass it back to the requester. Primary process does not store this fd
> anywhere, in fact it closes it immediately after responding to the request.
>
> Following that, when we call rte_vfio_group_bind(), we check if the group
> is open locally, and if not, we will call into multiprocess code again, to
> request primary process to open the group fd for us, but since primary did
> not store any information about the new container in step 1, it will store
> the group in local config for default container, and return it to the
> secondary, who will add it to its own config for a different container.
>
> To address these issues, the following changes are made:
>
> 1) Clarify meaning of rte_vfio_get_container_fd() to only return the
>    default container, and always pick it up from process-local config
>
> 2) Avoid calling into multiprocess on rte_vfio_container_create()
>
> 3) Avoid calling into multiprocess in group-related code, except when
>    dealing with groups associated with default container
>
> As a consequence, SOCKET_REQ_DEFAULT_CONTAINER can be removed and
> consolidated with SOCKET_REQ_CONTAINER, which now only handles the
> default container.
>
> Fixes: ea2dc1066870 ("vfio: add multi container support")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

The patch looks fine to me.

I am not clear of the implications of this change in the API and I am
a bit hesitant on marking for backport.

On the other hand, it seems this was not working in multiprocess context only.
Plus, this is about programming an iommu, and the (intended) consumers
of this API are drivers.
I found no trace of use in opensource projects using DPDK.
So the chance of breaking an application is low.

Applied, thanks.


-- 
David Marchand

