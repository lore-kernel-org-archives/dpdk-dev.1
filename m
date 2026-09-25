Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D4C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B7040DD3;
	Fri, 25 Sep 2026 11:56:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F23B940BA6
 for <dev@dpdk.org>; Fri, 25 Sep 2026 11:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790330200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mNrbl4Q2wiFe6ObxXlFsA8qrqryTpn1chrwT6MbUHU=;
 b=U1OSvtFU4cth17dh4MlLG3hIfYXVnCGuMa/vv+745SJpsBlD1shqWn52Np2wXRWVksHWqI
 S769BjLt4gvv4nNGEYFp0kUm28TVoT9lupW2sos4qZzv5rCHjzhbg/2S+SItY5zBKmnBAz
 BdF5BCy0rNF9mF2LNy/AGx/Td8iwJ1E=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-TCD8j14POYuEKBoF3ajQSg-1; Fri, 25 Sep 2026 05:56:39 -0400
X-MC-Unique: TCD8j14POYuEKBoF3ajQSg-1
X-Mimecast-MFC-AGG-ID: TCD8j14POYuEKBoF3ajQSg_1790330198
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-88e06764219so10578727b3.1
 for <dev@dpdk.org>; Fri, 25 Sep 2026 02:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790330198; x=1790934998;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1mNrbl4Q2wiFe6ObxXlFsA8qrqryTpn1chrwT6MbUHU=;
 b=1APNK6Et6zbuX3HZnfrS51fcFiI3nzryorqIJ+rw5GFjSzauV3uH5hMep5CjvHvIKY
 aXBg409XpIrDGiIQ2d378O7nIhv9w/hbmC0P4SSax66GpwNTLFiA+htrHqnH2XtTKGSt
 2ADBUzGTG6NgdsDWlD6vpTPdfxj4lxf7zzFtxifR6SAyBAH8CrS7uui4VhA8mMmhFiWv
 XLK+DkFnvq7yJJ2S1ykLuG5l+oNTWATTsxcKsyiqCvOgECxRclBbx+OjBi18+Sguub9z
 RVgBVlboiaKtEQRWsJDaY309HCv7t2E+IN48srRnllpNtIP22dwxY1PKRcHjfy5eTNUL
 XfXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4yCN2eLDcwiytgXRsE3kLZ5ipWRlFULRTA9fFdLH356GCCirWgIhX+7pTaO43LWJT/O0=@dpdk.org
X-Gm-Message-State: AFuF++m/I77JMe+CPMxCU17LDL/s9Wv1Ev2MWYRtu9pmExUEeVTreQfH
 xi4O3sbxuvxQb68uXYKE0sNM3k8zWEXIcSCkOcjTsaMfxwxavqw/lx8I8HP2M3CvnZRfpG17b3a
 uSnTnnBGoXR1cdFumKcv3cE2SwwzOXpKUZfCY8CMCay6CMh3nTP5yNdSFhrAwJyJVRKRyzNaWcN
 d3a6RXS6rzHQwEprgWs2Q=
X-Gm-Gg: AYBFou0ZdNhTKawENjNinslG0tYV/kwXlVNUC2fNxb4BKT7r/HuipqEZpU8sMLlyYOP
 9WzEz8CJdHOdhwYsM0TkrKaglnUosLib9fJ6jHuqFOcX+NOqh7/VeahmZ5o46Hl15eqTgy+FF8K
 GKGsC8PaMwgPrmloDtHfOEquFdt4hyKxzr6oHgonXDxHwMICnRVFEkAkUF/kEoLjt49iAIU+EaC
 f1PYWpuq+rbNol/gA5aHwBxbgn8OO0kuK+mtJGA9LD6VBNEKJNlbmU685Q=
X-Received: by 2002:a05:690e:441c:b0:66f:c1bc:880c with SMTP id
 956f58d0204a3-672ed48cf27mr1429058d50.101.1790330198324; 
 Fri, 25 Sep 2026 02:56:38 -0700 (PDT)
X-Received: by 2002:a05:690e:441c:b0:66f:c1bc:880c with SMTP id
 956f58d0204a3-672ed48cf27mr1429047d50.101.1790330197782; Fri, 25 Sep 2026
 02:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260924101504.810315-1-eperezma@redhat.com>
 <20260924101504.810315-2-eperezma@redhat.com>
 <20260924083845.4d854df3@phoenix.local>
 <CAO55csxMp51tJqjMLdbQUAXcTT_V7_iadUU0AB+aXwiDc30X0Q@mail.gmail.com>
In-Reply-To: <CAO55csxMp51tJqjMLdbQUAXcTT_V7_iadUU0AB+aXwiDc30X0Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 25 Sep 2026 11:56:01 +0200
X-Gm-Features: AclHuK-33_RU5lAQULe10sZvecqWd-QvKCJdLciPMuETO9wHEtf02fgKr785Iz0
Message-ID: <CAJaqyWdegBFY2tMEFD2AU7eh==H5GJB0yngSOnJ1Y7wgZnrk8Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] uapi: import VDUSE and VFIO header from v7.3-rc3
 kernel
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 chenbox@nvidia.com, 
 Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com, jasowangio@gmail.com, 
 david.marchand@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ter4aKj6OC5tGd-ng6HQqx7Di1EbywuCgwyUwZsrH6U_1790330198
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

On Thu, Sep 24, 2026 at 5:51=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On Thu, Sep 24, 2026 at 5:38=E2=80=AFPM Stephen Hemminger <stephen@networ=
kplumber.org> wrote:
>>
>> On Thu, 24 Sep 2026 12:14:56 +0200
>> Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:
>>
>> > This header will be used by the Vhost library.
>> >
>> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> > ---
>>
>> Best to avoid using headers from pre-release kernel versions.
>
>
> Yes, that's the plan.
> I asked Eugenio to share it early so that we can review and test the seri=
es. It will not be merged with -rc headers.
>

My bad, I should have stated that explicitly in the cover letter at least.

