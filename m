Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5059C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 17:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFB5F402D8;
	Tue,  8 Sep 2026 19:40:24 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 59F464028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:40:23 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2db858d60e0so7412855ad.0
 for <dev@dpdk.org>; Tue, 08 Sep 2026 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788889221;
 x=1789494021; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GrxMi08hD93qvwY5gnl0r3WWFGtysMrjBaeKKnP3iJA=;
 b=nygmk7GBjGBmk3Mz3eOXlXaApQAbKEHbv14bjiMvyeBJGaMS7QbrUqy9HsMsXWetDe
 fYRXfSECAd5H424l4bQXZGt0dhAGlEY8Sy//AH3ayHPoSLGOeZgiYATMlh7pLJMxyVm4
 TsTFKqbdsK4Q0Sc9bF2hjziOxMvxAZO0gP4clEklcxw3oIg2wBs6FzvK/IyWB0All37j
 22GZsPDn/EyffLaME0tlU2Gp/2TrETkc1SEqtfYL5wHvzITJVrA6STqd1/Fn1yr+qYtn
 sD6UoKyOhx6hxJBJyQ0UF0HFQKHR8LuRZ3WdRlEeCZYeX6k1ynR6UQxjgVEqjsnh5uxt
 aaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788889221; x=1789494021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrxMi08hD93qvwY5gnl0r3WWFGtysMrjBaeKKnP3iJA=;
 b=XsnBB8xwpSc1vV4PKtVcGfM5DfdhoxuKZl2ZEySthoJTrH95C+GNCyDeiD4PDtqG5K
 tE8CWtiXE8lOT80hQFNUuL1GVtKi1dQy0WP4HFqTvBY53SIkT+3stNefxCtnhv2k0Ei/
 XhItN5+71HqS4Oldw1UH68b4hfB6EivqS3mpQAGnHzrDaphUv9JrFB9+/t1T6NRzrZxZ
 TdgNns+oG/1b6JWWpO6Y+aM/4py2Htrdx0sYczKISoTZWQQk0RDFtTfLCHhpYEZ0yVLp
 8NxuWtQUMmaUbHuwJKBc1A52XN7MB4veV+hSKgQ4FX6hS/01ICQsXKogM1yQOlDZw0av
 JG4A==
X-Gm-Message-State: AFuF++kybpilp+gtQL9yjtYI5irdOPQBLuXnSZaFcuKp+Tic6pvJKJ55
 ZYCcu53KToardRkTILh4qfBWkRcf7XN8OMseTS9caDMRIK7x54fcn48Q5tuaHqateF8=
X-Gm-Gg: AYBFou0PvvqXW0JxHucGbHnzUhDwI2+MqCDK3biB7c84w6eGVwkqEGdyBFJbPzayiM4
 bY7X1gkzWiNSpWEtieN83jYhQPPUWvF1veVUPa5qwxuXsjeAXWBphPf78StqisYSrdnIH0fv/yF
 5FpVsmVoHuNfkV2yjchhZIq5hibBPdzMffLMJgoKhUYv5SfKls+RMScsmgX0r9lqGH9ot5lIJLr
 u/mohzBr5xGS7oUaiel8YXXz02LCQ2r+zSbpoBQTs5aokwMctK8GV9PlvWrfBHHceZFRwlt6YbW
 e8BsNJMv9FrmzrvoD0csyJlgpKK2BkB00R7Ej+Pc9sQ44BACl5/4DhO4UvQfUmADFs5y44zgJva
 1iisYlvo8aZbRMi9YTRNEyd5C7ddHMJ+DAAjmLMykuPJCmt5bojliZwivKe4825/N0ZWMYVG1zN
 bzEINJq/L434qCcy2zqOfubYUSmdcsuNe6NEaSBNMtfw43DQgPsOJft/nHU+upx/LehdJnUax5K
 mDcIcIYV+BCSxBpJqLdZxbxrJGCUg==
X-Received: by 2002:a17:902:d544:b0:2d8:d4cd:dc8e with SMTP id
 d9443c01a7336-2db12666d73mr484348985ad.17.1788889221149; 
 Tue, 08 Sep 2026 10:40:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499df27sm62145285ad.50.2026.09.08.10.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:40:20 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:40:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mukul Katiyar <mukul@versa-networks.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] Highly efficient reader-writer lock (EPRW) for
 mostly-read applications
Message-ID: <20260908104012.7489b055@phoenix.local>
In-Reply-To: <DS7PR11MB885556AF77C5110C85609B7B8CB22@DS7PR11MB8855.namprd11.prod.outlook.com>
References: <DS7PR11MB885556AF77C5110C85609B7B8CB22@DS7PR11MB8855.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 8 Sep 2026 03:55:12 +0000
Mukul Katiyar <mukul@versa-networks.com> wrote:

> Hi all,
>=20
> Sharing a userspace reader-writer lock that has been running in productio=
n in a DPDK-based network function for several years and wanted to check if=
 there would be interest in contributing it to DPDK as rte_eprwlock.
>=20
> The Enhanced Passive Reader-Writer (EPRW) lock eliminates atomic operatio=
ns on the reader fast path, giving near-flat per-reader performance as core=
 count grows. It is compatible with poll-mode lcore discipline =E2=80=94 no=
 heartbeat or periodic refresh required from registered threads.
>=20
> Details, correctness proof, memory ordering analysis (x86-TSO and ARM), a=
nd performance evaluation against rte_rwlock and pthread_rwlock_t are in a =
preprint at:
> https://zenodo.org/records/22636501

Dead link.
I looked at the original article as found by web search.

>=20
> Would this be a useful addition to DPDK?
>=20
> Regards,
> Mukul Katiyar
> Versa Networks
>=20

Send it as a patch. I have looked at lots of different reader-write lock im=
plementations such
as phase-fair and mcs reader writer locks. The trade off is always cost of =
lock acquisition
when uncontended, versus behaviour under heavy contention. The current triv=
ial version is fast
when uncontended; other algorithms add a queue (like mcs) which makes them =
behave better
when getting hammered by lots of contention.

DPDK was also fixed to not starve writers several releases ago. It seems th=
e research
paper is referring to original old code.

Also using reader-write locks should always be discouraged. RCU is a much b=
etter solution.
