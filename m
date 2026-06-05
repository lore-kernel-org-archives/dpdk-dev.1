Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD40CD6E74
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 13:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F3BC402BA;
	Fri,  5 Jun 2026 15:14:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D64F4026A
 for <dev@dpdk.org>; Fri,  5 Jun 2026 15:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780665271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bxe8wIKNu2hVYbx0ZNypJaCaBSbYVb3O9NXL3i2uRmQ=;
 b=h1q59RwEnC1kMRJGbWdV7OxeQ488UvMzrfFjcyxlzik1ByeFBbvHcHmawt1BoUW3fshffm
 l2nrhMTZF2j2ZT25z4iwNkddVgqsFhSutp30WAg51zNTtQgi3UrnsPVWWoDmwarsvwpO2b
 R87DgXv+WQbMaAi/GmU62PmEHMjVzQU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-b0KN68oqN9WNFF79-vbyLA-1; Fri, 05 Jun 2026 09:14:30 -0400
X-MC-Unique: b0KN68oqN9WNFF79-vbyLA-1
X-Mimecast-MFC-AGG-ID: b0KN68oqN9WNFF79-vbyLA_1780665269
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-396770a5858so12182601fa.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780665268; x=1781270068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bxe8wIKNu2hVYbx0ZNypJaCaBSbYVb3O9NXL3i2uRmQ=;
 b=AS9Q2cxtxxtqlQsiIISuQBhdDpm69Xa5JV0bbOA6fmK6lMLZmF5RaGnhQZh3tmdwSB
 Z6+vUJckaFB6nv+jlcL36AfbpBV2NLDPuOMIrqyP8gCe5VUhNW5F9yiDHpFvSswEG4xG
 xsC37BSitLRYY8Ncd7k6sSwsR3qxSO92Tsz2V+WirJkMNWnEVNW9+PFq02fRsjpFAVjX
 wulw2Zwz/F46exXoahUZXrRiymA4rhJw6T6fiaV2d2dXd7nGwRRvbeQ4/Z+Mcq1iubwp
 cw5ETA3pEmrXs0Ei2/JC9sV0N61kXW5EPLfLH0CnAcupECY8a675l0S06Rbnq7OOXh/S
 k5Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zhTddJUC/ChvIvz3/QpzZbYDSG/VeEN80FeKJ4QgUG4rqrD4NNfgJCG/p9QT6gwdcaFU=@dpdk.org
X-Gm-Message-State: AOJu0Yy7oj5w+P7MyDUwTdD+Lv0BFzwhn4LP7gA83yrKo/C0O1sAPVXn
 OCuYcEm1gI1rdjzW0yKF+V/aA2t/SItJofY1b0eSlH35f3PBGzT7RL2CHrg1QA1X/JKKldCvGak
 AsJ2qstIYTyo2Zi2/xoEuK/lc4as+mFbDP0Ng2N5ADpkmhrmneQk53iSF6M/Q1DT821FNn/1YZs
 +6jL1jXU80ocYJTVxBIb0=
X-Gm-Gg: Acq92OH1saYYBG5Uy43dcmLMHwdqwUagz7unwB20tNCgShyO4nRW3Ko6i0pHrTZScf5
 ikY5P7m6h3vdsdeaNw4SgC7gxmuuV5nodvOLgt6wzv9RATJwKunun04xe3GTZilmBxoqD6EM75P
 +m2LjVzQS5YgZsqfcO6ZUyN9H/d+HHfMYg6QBjsK+Pv6RxZqRwIAlKCkHXfzpeTv82Tvk7kx9m5
 x8Y2tc3lqOiV+BLX4DHLuWTKZdHMNC0IHiTC1FHw9D/aHHkjugtqnv2a/vuRhx5DhxC7WKOwG5j
X-Received: by 2002:ac2:51d4:0:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5aa87befc37mr1139539e87.41.1780665268472; 
 Fri, 05 Jun 2026 06:14:28 -0700 (PDT)
X-Received: by 2002:ac2:51d4:0:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5aa87befc37mr1139528e87.41.1780665267983; Fri, 05 Jun 2026
 06:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251030065715.47304-1-fengchengwen@huawei.com>
 <CAO55cszyJmM-iGYPXOh7UC7Gh831kQA9QCzHi1niyyKmB+=Pwg@mail.gmail.com>
In-Reply-To: <CAO55cszyJmM-iGYPXOh7UC7Gh831kQA9QCzHi1niyyKmB+=Pwg@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 5 Jun 2026 15:14:12 +0200
X-Gm-Features: AVVi8CdBckJT7vrdSguuJphetVRYGq9cABnlXPchYm5I9w75Ahl3NL8PBxxREg8
Message-ID: <CAO55cswQmL51rmOrM7ndtOop6t6UhPN_xFjukw16kDE9Tm-mUg@mail.gmail.com>
Subject: Re: [PATCH] examples/vdpa: support show protocol features
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VIvUo0h3WT4-JdP1l7dS_WiRoWH5uC2ABknrevOfVAM_1780665269
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

On Tue, Apr 28, 2026 at 11:23=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On Thu, Oct 30, 2025 at 7:57=E2=80=AFAM Chengwen Feng <fengchengwen@huawe=
i.com> wrote:
>>
>> This commit adds show device's protocol features in list command.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  doc/guides/sample_app_ug/vdpa.rst |  8 ++++----
>>  examples/vdpa/main.c              | 13 ++++++++++---
>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>
>>
>
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> Thanks,
> Maxime

Applied to next-virtio/for-next-net.

Thanks,
Maxime

