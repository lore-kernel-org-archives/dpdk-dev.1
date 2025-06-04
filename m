Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CE5C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20DEE42E94;
	Wed,  4 Jun 2025 18:02:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 679BB42E45
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749052969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjgDWIHGHp5HRpRS1rTEIDgyIrIKw6/apfEp5F8IXUI=;
 b=F6QYYKm4/cKmLZGLahDH0dbVCX7j+tZyZ4xAQPB3th992ewMW8S6LcqFHhuiWWlXPfPuG/
 XIENAmKpqpoVBI2vPvUv2FqFtZ759AUC0oUSclQijf/Oa0cm0wz9Y02TGgIPqxpeYvb7S9
 CjpZZ+be9gi/I0dVM58PBzWN0C6ejz0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-KEU8kjKxNnOqAflPc-5TMw-1; Wed, 04 Jun 2025 12:02:46 -0400
X-MC-Unique: KEU8kjKxNnOqAflPc-5TMw-1
X-Mimecast-MFC-AGG-ID: KEU8kjKxNnOqAflPc-5TMw_1749052965
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5532a2d970fso3712067e87.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 09:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052965; x=1749657765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjgDWIHGHp5HRpRS1rTEIDgyIrIKw6/apfEp5F8IXUI=;
 b=la4EQL2DGSQFEzNJn3eWvjEOVcQaru4bG1jYOROJ7/imMpHi4f0RWa6q+kRfYnD9yb
 /5OV2jrUVEcuXjirWw9cQ7GC0u/2hx51YBJwwdS6TuJCa9yAR7ujFIwBcQo53mkEfJ9b
 ZXHMaLysnukqyvKsx4i32XisV45ftbMrGGJvf3p4zZL/I0W9CfDTlg2sfx2V0tEP1/gq
 EdLvbg+vvH1e/Kl8DGq1Lq9pjWJUlkA3XYv/dv5IzckdobwEc0ez3SJ1nTIlaHOPwfQ1
 n/qrTqjW9kc2HlO64wVeqJzHaSHKvtPMpdihG+ofuhrDiE8j6Y8ncNVpqolmeEjKRhkw
 sZ0w==
X-Gm-Message-State: AOJu0YzI1hg/FizTxkezk5B5Ix9+K+wKxzSMEFJdGsEDYcgh3oAEs1cT
 DjS6HxeSi5DyT5EAWB4WoHTJ+5qMNxCguwmbD535PA0MxpPa4h2Z2Rc/kT2k03yV2YhmlS+4P6T
 MDbDjlVDDN8kXF6kqBnyJ3NWA7EbE5CEubvwFppOkrTHVNJxG2S+G8gpSPQl9wASi6MSL1gCCBg
 CT4v4L3idC5TGDDYpXrpw=
X-Gm-Gg: ASbGnct0QrzuBOnNdWyKYNFnNmz9EWcTG6ykRILs2iTTVWyBWG2miMsQ14BrC+NEOLU
 I3++BDaEycwhBI2Bk9gwmqMnvOpRJFvQnRcJO4tyCq3ESOSKQC5Z+MDipKzI/ktxzSMP+olA=
X-Received: by 2002:a05:6512:3b0c:b0:553:3586:9aab with SMTP id
 2adb3069b0e04-55356bf96e1mr1204119e87.31.1749052964666; 
 Wed, 04 Jun 2025 09:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo5CNVBMV/9C3KBy+x/fcGXFVlHuwyigRBnnGtZy8HnOKSwvCkOGX12ACb8XTqARqhue0RVO4lnSccQelZ6mc=
X-Received: by 2002:a05:6512:3b0c:b0:553:3586:9aab with SMTP id
 2adb3069b0e04-55356bf96e1mr1204079e87.31.1749052964182; Wed, 04 Jun 2025
 09:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250117125912.985475-1-bruce.richardson@intel.com>
 <20250326171420.2095264-1-bruce.richardson@intel.com>
In-Reply-To: <20250326171420.2095264-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 18:02:32 +0200
X-Gm-Features: AX0GCFsO7IGOLtrmCz8K-OyMvCEkyqqYHUc2nVbuNCIyWbKxZnE28AR3WnEfmtk
Message-ID: <CAJFAV8z1PvHiby4JDHrV7p0121qADp8Oo_b9g+VFqChtDs4Cfg@mail.gmail.com>
Subject: Re: [PATCH v5] test: improve resiliency of malloc autotest
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wjCUe0Pc-2jLojUeTo83Z9UVU7CeP-nPGQ8sRPNA6ds_1749052965
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

On Wed, Mar 26, 2025 at 6:14=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The test case "test_multi_alloc_statistics" was brittle in that it did
> some allocations and frees and then checked statistics without
> considering the initial state of the malloc heaps. This meant that,
> depending on what allocations/frees were done beforehand, the test can
> sometimes fail.
>
> We can improve resiliency by running the test using a new malloc heap,
> which means it is unaffected by any previous allocations.
>
> Bugzilla ID: 1579
> Fixes: a40a1f8231b4 ("app: various tests update")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


--=20
David Marchand

