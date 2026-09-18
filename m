Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66CEC982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EF744279C;
	Fri, 18 Sep 2026 19:01:55 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id E99AC40285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 19:01:52 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d8fdc579daso11089905ad.1
 for <dev@dpdk.org>; Fri, 18 Sep 2026 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789750912;
 x=1790355712; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tciZR2cWMAz9ZvhwXdxRlR6qquSTMsVV0LqQM8gRbHg=;
 b=0BtIlqEna6Bng8Uh3YGYSbhUiqntFXGj3kFSY5DIyWZ8q7s3sgKZUmOOStkcHzH9ql
 9vU8HyA5oyMr1Wi8rP56q00gQ4zQ915tX2l9h5veCgs/69la5IZtWnf7G1iXFyOFtTrB
 APj/mscLXK3TYVu5PZO28tICMtA6nkxtfq9VE1atMMCCPMY+HX0K08CFQwW03oQ76eaZ
 7ULpXL4FullprXV8+6n1GYb+NUl8UX69ZUdmwbYSv8mWR6uXkuZ3ETCqQEqJEgCQdy4f
 M2lLGl3lEiC+jxbet9huld8p1iYWi0zDRHtO3JbpCGyMaw6pnxW6sXBbdVFZSiGgMClv
 UlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789750912; x=1790355712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tciZR2cWMAz9ZvhwXdxRlR6qquSTMsVV0LqQM8gRbHg=;
 b=T5AfOJ31/Fh42g4ExiGI7Z1vI+CGCjuruDTNVe9W3cyGHT1mvhKdyTyNxwzWnd1Znq
 L578Vkql43b4pjP+uROQuCbsQ3+kkzovFFfqLWLYCN6BfuUqGahROGzxCsgJq2IJFfcG
 f4DakSd7c01t1KHYxblA39GgAZ19qmUcbUhrRZ/HavrPqRuzzS3LgoyxG/iGt4OsgZj3
 WQCr9g6MEOIasqkZDnHcdOdgVzq883dcpUUJDV4hcZdgh5mRS0N5oYXhGuM+kNzWNZkb
 eDr2sM/K7Sc31zMXW4X+4isM2cnncXvh7FCzx+aM0zQNXGLl1P+IQHV22kZd3gEQp3hr
 HhqA==
X-Forwarded-Encrypted: i=1;
 AKwUvByqK2RwKsWXEWixE54WIS9ROI6K0Bj+cQHaXO+pPtf4sMZEQu+slVvbhLVb3i8yn/JhlI0=@dpdk.org
X-Gm-Message-State: AFuF++nC18LM1hdpaA81hTEzTtFjZljDoL37x92g4h6ELgAXqviltKrL
 mF3CkVJc6vADB5pthj1cF3w3+ETi/EkyCp8ilgIsW6UFCL0iUB7Z/zY7seqhByvgt9s=
X-Gm-Gg: AYBFou1aeITUlQOplnOj0l/Gu5DHdRRpadfV+H65lSAEviiprHWgfj6BL5EmeXkr6JZ
 p94vP0Uhvn5/bTqrvDOwe+vfGn0XnB4TP4HTLJEj2mr+eEc2G/1MOAPU0+F6o70uupV71T12yr+
 Imk6JIESclu9RxxgWGEuJ3SEFSAacssawWdQq7UPkgAzE08mixQDmQvSnrK1P5/hZfKQg2auM3u
 cWVd0fTfFHPbG2hUHAXw+veh2ZQ6DWBYKO28SPd1A9uLCBaj30N4pLWWrPnGiz0YazCBYkfxXHA
 abomiMKM5O6hJ+5z7nD0E/C3TQT/tBrSvcCusguSipYcDDsl7S+yWNc1jdrpjSl1L4IGwuXTEuW
 fytAlz+D/Lw53Eizv9I3hI6cyQ1/o9g0SLHHRt8jEPB8U5IBG8FHNG49DGFdLP6Aki4ihEdXE1d
 YzmqlMerMtDEN5SjUZAhTD+64AZb23EDmtjiZw7/i9zVg3w8YAbddkjCkIRHihJdknXxcOjKZLd
 4muuKkk/TI+I9dv6MkLA8iu8DogXew6Jxfdlx9A
X-Received: by 2002:a17:902:d4c4:b0:2dd:ad74:ac1c with SMTP id
 d9443c01a7336-2ddb1ba982dmr62118125ad.23.1789750911575; 
 Fri, 18 Sep 2026 10:01:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb73db302sm11744635ad.2.2026.09.18.10.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:01:51 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:01:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, "David Marchand"
 <david.marchand@redhat.com>, "Robin Jarry" <rjarry@redhat.com>,
 <dev@dpdk.org>
Subject: Re: EAL feature request
Message-ID: <20260918100148.08152799@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A50@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F65A50@smartserver.smartshare.dk>
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

On Thu, 17 Sep 2026 14:48:24 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Bruce, David,
>=20
> I don't know if this would be useful or not, but here goes...
>=20
> Situation today:
>=20
> DPDK has 3 types of threads with a valid lcore_id:
> 1. EAL threads,=20
> 2. Service threads,
> 3. Non-EAL threads.
>=20
> EAL threads are controlled by DPDK, and associated with physical cores at=
 startup using the --lcores=3D<lcore_id>@<cpu_ids> parameter, and their OS =
cpuset/affinity etc. is managed by DPDK.
>=20
> Service threads are also managed by DPDK.
>=20
> Non-EAL threads are application created threads, which are simply assigne=
d a valid lcore_id, but their OS cpuset/affinity etc. remains managed by th=
e application.
>=20
> Furthermore, macros such as RTE_LCORE_FOREACH_WORKER() only iterate over =
EAL threads, and rte_lcore_is_enabled() is only true for EAL threads.
> AFAIU, this means that DPDK only considers EAL threads as fastpath ("WORK=
ER") threads.
> (The main thread is also an EAL thread, although it is usually not a fast=
path thread. But its OS cpuset/affinity etc. is managed by DPDK, which is g=
ood.)
>=20
>=20
> Feature request:
>=20
> Functions to create and destroy EAL threads at runtime, so applications l=
ike Grout could dynamically create/destroy threads that:
> 1. DPDK considers EAL (i.e. WORKER) threads,
> 2. Have their OS cpuset/affinity etc. managed by DPDK.
>=20
> Such functions would probably need to take <lcore_id> and <cpu_ids> param=
eters, for dynamically updating the list of DPDK managed lcores and CPUs at=
 runtime.
>=20
> Maybe the ability to dynamically manipulate the <lcore_id>@<cpu_ids> mapp=
ing could be a separate set of APIs, so rte_thread_create_eal() would not r=
equire those parameters. (Don't know, just brainstorming.)
>=20
>=20
> Reason for asking:
>=20
> Because DPDK doesn't provide this feature (hot-plug/remove of EAL threads=
), Grout has to take on the task of performing its own thread management (O=
S cpuset/affinity etc.), register its fastpath threads as Non-EAL threads, =
and cannot use RTE_LCORE_FOREACH_WORKER()/rte_lcore_is_enabled() for them, =
but considers Non-EAL as fastpath threads.
>=20
>=20
> Generally it would be logical for an application to register its control =
plane threads as Non-EAL threads to get the benefits that come with a valid=
 lcore_id. But how then can DPDK discriminate between control plane and fas=
tpath threads? Only the application knows.
>=20
> It would be nice if DPDK's perception of which threads are fastpath or co=
ntrol plane was aligned with the application's perception.
>=20
>=20
> NB:
> For completeness, I should mention threads with no lcore_id, created via =
rte_thread_create_control(), and the OS cpuset/affinity etc. managed by the=
 application.
>=20
>=20
> Venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup
>=20


After thinking about this a little more, it looks like the best design is:
   - have fixed pool of cpu's reserved and isolated
   - in that pool make sure and skip cpu 0 and its sibling shared core
   - use a script to not only isolate cpu from scheduler but also IRQ mappi=
ng, RCU, etc
   - start DPDK with that full pool of isolated cpu's
   - keep main lcore around for telemetry, management, alarms, etc.
   - launch worker lcore's on demand; start with one and if load gets bigge=
r than use eal to launch more.
   - if demand wains, the worker lcore should return from the thread routin=
e and go back to idle.

The key concepts:
   - keep worker cpu's isolated
   - idle workers sit in OS asleep on mutex so can reduce power/load

The hard parts:
   - deciding when to ramp up/down active worker count is hard heuristic to=
 get right
   - reprogramming RSS and flows when workers are added is non trivial
   - stray packets during worker changes
   - synchronization of worker addition and removal

