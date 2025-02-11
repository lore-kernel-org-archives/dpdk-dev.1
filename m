Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670F3C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 13:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3377440156;
	Tue, 11 Feb 2025 14:21:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6D4AF40150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739280066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WUjkH9zfBn+1Z97nNjWR81SZ3SMxAr84sEASdP/mJUk=;
 b=PsEDwFFeirjovq5PCeCFEKJHQNDdTnhzW+dFNmBcjri2SWYzeuuoaP3rEvvCxfia7ATsxe
 4v2XjJyClPbi2Jm55k0ojQTHpHcrsOnaJkUgBvjq7VlSQ5Pcl/BhHp4d38Up2YvLReBvSZ
 5W2wBYAsCbYa68Y1ZaWgHyAFEgYaEAk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Cbmgcf5cPNKHr77QeuSJdg-1; Tue, 11 Feb 2025 08:21:05 -0500
X-MC-Unique: Cbmgcf5cPNKHr77QeuSJdg-1
X-Mimecast-MFC-AGG-ID: Cbmgcf5cPNKHr77QeuSJdg
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54511c5e46bso378576e87.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 05:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739280063; x=1739884863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUjkH9zfBn+1Z97nNjWR81SZ3SMxAr84sEASdP/mJUk=;
 b=qKu4W70rUOVoY7X4dgkoJytDXQQj7g+9JAbPjwpYlgrG0GUFXVFVnSTiSTm7TZaTRj
 P2IXoPARKywKvwHhq34tnLYA/qTwdNN+XtdKSUpuO3adVyR4vFMChNsNaxENBcegMV7L
 sF6Ml9PvdwvFkYs6t1LH8Aw41KJc+cbHGuwOIbGCaRG0/N9j75czgD6f9k06YYWCMSWz
 tO1hM9OsRdz6QLxGjy5rVKduoH79bBXV3+ZMdo1onl+XfHTJg01QYubzGZs2oGu7SJZu
 T5zAbcNmL1VEt85GCYrcZpPFqQBb4OAX7+aEO7G088ZGs5lz85wcqo/Zv4k+C1d5JmRP
 vIlQ==
X-Gm-Message-State: AOJu0YxCvQlvoUyQUs2R2p3iazTwynKYgRpLXHr0B+K0jICvRhffIENH
 7AF2mVcdDhcjowCvRnH+tcRf1XM9Y3O1qETffZTC/TYNcmOT0uFv7rBw9d22zKMURlonJ4FkyhI
 tTyYX5WyDxOOHc/qqGMCriQia3OD0I7KmrZGHxItyzWYfqS8nTJcjiOPLDEVEI8S1PTISsGEfOd
 aezi6GEMbVQ1qLwAQ=
X-Gm-Gg: ASbGncv5J7LkYQhRaaOvnVGI+j+ZUF/6J2YlWvfBzSSm5ytSxmIfkPURBuj/SKVuL/f
 URB7YNG7TA23qQ71Kn7/zrYfyaxgpBWChILRQZ1Jb9f2+TSa4bd6Xd91a1fcUqr/+
X-Received: by 2002:a05:6512:3a92:b0:545:1082:919f with SMTP id
 2adb3069b0e04-5451082958cmr1496446e87.2.1739280063180; 
 Tue, 11 Feb 2025 05:21:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvU1nGjKKLJ4dr/KvQPd8c+8nNfSn4j16InH15qwcy4Af4s7SWvPrp7DJ146BWF9s07hyJpF+KBEGx5aMVra0=
X-Received: by 2002:a05:6512:3a92:b0:545:1082:919f with SMTP id
 2adb3069b0e04-5451082958cmr1496439e87.2.1739280062812; Tue, 11 Feb 2025
 05:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20250130172624.1450975-2-bruce.richardson@intel.com>
In-Reply-To: <20250130172624.1450975-2-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 14:20:51 +0100
X-Gm-Features: AWEUYZkmNXO-ovIlyAQBOuR2GGtojRub6GVH3hK0ndgDkbAhO7jZ3v-UQUippbU
Message-ID: <CAJFAV8zTpB3EzZJeb2mpW0UqAfaMVjBYat7L+pLaYYpYwcEnwA@mail.gmail.com>
Subject: Re: [PATCH] dma/idxd: add device ids for new HW versions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kevin Laatz <kevin.laatz@intel.com>, 
 Robin Jarry <rjarry@redhat.com>, Kevin Traynor <ktraynor@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wuu45iFyck6fcWyRuLporW8F-G_5c7k9eUavUDhT4a0_1739280063
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jan 30, 2025 at 6:27=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Add in two extra PCI device id's for future HW versions to be
> supported by idxd driver. This aligns with the definitions present
> in kernel idxd driver [1].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/dma/idxd/registers.h#n9
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Cc: stable@dpdk.org
>
> Since this only adds a couple of device IDs, and there are no other
> changes to the dma/idxd driver in 25.03, perhaps this could be
> considered for backport for 24.11?

I prefer not to mark with Cc: stable@dpdk.org, because this is too
vague and LTS maintainers may apply this for 22.11 or 23.11.
For this special request against 24.11, the simpler is to send an
explicit backport request to stable@dpdk.org with a 24.11 prefix in
the title (and copy Kevin, who handles 24.11).

Patch applied, thanks.


--=20
David Marchand

