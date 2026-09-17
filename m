Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA8C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:29:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C2A42E1C;
	Thu, 17 Sep 2026 18:29:03 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id AE5FE40E4D
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:29:01 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd77300825so10808005ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789662541;
 x=1790267341; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9fd1S3i0EI8itEjc79FoAAzT6iIDbTuqqFwSOlLppQ0=;
 b=wIat62d1GG+0Y6hCJcc6GwDVz6MPdIvRl0CCrwPtB7YeELbErFcfCcnRUp2En3Xv2l
 I0A694f6VThGbW/tqNh4Bo8ZPlqvnbNRGEtsP5py7AMQlOh6WKr42A10Uab6lvUEovJe
 T5JlIeBrsXhz25eRwC8n1flIr84lAGiR+GXapRaPrWJe+SSjT8PX6tnoHXLBC+dft2pj
 AohXY8u3zqdt5Vo/vkPC3vOVn0XCFnIvDzhJSsQF8/I0f2UosBF1bM5l2sSSvSU0MUbS
 fXoQFvanTlMq1BTSPyTEYPjxzzvYx770qAvlIzqF63Q7Z9/xULcO1fMUt2fEgdjyKXYz
 DRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662541; x=1790267341;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9fd1S3i0EI8itEjc79FoAAzT6iIDbTuqqFwSOlLppQ0=;
 b=CWbH4Epf7JlEBTbY7rmsKymyEyy1dwiHJTqlGcjYDOn7K6t1rIZynimjmIw4dJI3as
 l+gnh4gg2KJ5rnrJHLNd45oHcgDC+t9MxTjNrfV4hvgoBKXgxa/1BmxAmReAeQR6jBC3
 g0pwMfISxGas8ZL2kZMHzpp8eTtIO78jkaixyB0ECQ77NEiXWsfax6JJGW/Omc1Ce+Y9
 CLwWCR1tiyNPdHPccZhha3YqqmAbRR5XA9cc45UXwm27OLVWLxZaphUmK3Wdvya/yXn1
 uPl/H+WsgugCF3VVY21/u/4zQMN1cupgbZoO98kS8J7SJwMtvXVzJB4d302xYfaoyjgb
 8lUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiffxwH1DnyFbFmfMQppS8nTk3gDqFMBs54PBANPKifzUbH13VOddPpbo+He9Z+szEdWQ=@dpdk.org
X-Gm-Message-State: AFuF++llSGXKwYLmxnIogRG1jvuagTDdfh9s9m9JFg0iSof3ObCw++nX
 3epUcDUypIx7R3G/hTT7h6QgPRh1j7RGeXGn342pyYEu42UC7wgRjVLVdSjeOvGbIRI=
X-Gm-Gg: AYBFou09WUZFfkYG6ERrEQb6hTm1/s5JJng6Gan2F9euQgEMm+NfnY1Qc4L+ZTsHJXZ
 LRMVgir9Sc2bNi5Mh94IJGAf4kzXGOq2ghfQrOf6niVkyt173OsIi3L61OsEh1rG4mqPeckYAs9
 6mUU4tMByK3bvaVEcAjJXXf6046qw9VVUbc+u68sH42VfoAk+arTO7xoY09Aoh6eKrU2+EiNX3k
 YKf6dc8p2ZRr6Eu+2vWJyHU/keM3qZksdndNsHe7PxqttyfpMh4PmgJC14agd6IuGHb34TUD1Ri
 Ao01z+he554Muap98URDimgX23f/vOAniriveQF0xGH+m34b7tw6UZ+dlUYivqVK00D+RFcsMO1
 seRckvwZg47c8EMc34S2sZQv1wWFrsaaCoE3NQO01LZ8g463HZKirKxW8NljYpu+wAgWljpkj7E
 GkiCkgxJv2flj/+faaWG11NydpYy9NrGKlo0NRumM68hAf/86+O8jBXFZcQc49013xtNFILu2kg
 mdseMFMZi04yQaIyU2mDBnwWFw4+g7OzpgvJzxW
X-Received: by 2002:a17:902:e80e:b0:2db:3d84:effc with SMTP id
 d9443c01a7336-2dd8e00f104mr150423725ad.6.1789662540623; 
 Thu, 17 Sep 2026 09:29:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89e991d1sm28812875ad.26.2026.09.17.09.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:29:00 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:28:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, David
 Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>,
 <dev@dpdk.org>
Subject: Re: EAL feature request
Message-ID: <20260917092856.47bf969f@phoenix.local>
In-Reply-To: <aqvktFpwJsLqeY2L@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65A50@smartserver.smartshare.dk>
 <aqvktFpwJsLqeY2L@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 17 Sep 2026 14:01:40 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, Sep 17, 2026 at 02:48:24PM +0200, Morten Br=C3=B8rup wrote:
> > Bruce, David,
> >=20
> > I don't know if this would be useful or not, but here goes...
> >=20
> > Situation today:
> >=20
> > DPDK has 3 types of threads with a valid lcore_id:
> > 1. EAL threads,=20
> > 2. Service threads,
> > 3. Non-EAL threads.
> >=20
> > EAL threads are controlled by DPDK, and associated with physical cores =
at startup using the --lcores=3D<lcore_id>@<cpu_ids> parameter, and their O=
S cpuset/affinity etc. is managed by DPDK.
> >=20
> > Service threads are also managed by DPDK.
> >=20
> > Non-EAL threads are application created threads, which are simply assig=
ned a valid lcore_id, but their OS cpuset/affinity etc. remains managed by =
the application.
> >=20
> > Furthermore, macros such as RTE_LCORE_FOREACH_WORKER() only iterate ove=
r EAL threads, and rte_lcore_is_enabled() is only true for EAL threads.
> > AFAIU, this means that DPDK only considers EAL threads as fastpath ("WO=
RKER") threads.
> > (The main thread is also an EAL thread, although it is usually not a fa=
stpath thread. But its OS cpuset/affinity etc. is managed by DPDK, which is=
 good.)
> >=20
> >=20
> > Feature request:
> >=20
> > Functions to create and destroy EAL threads at runtime, so applications=
 like Grout could dynamically create/destroy threads that:
> > 1. DPDK considers EAL (i.e. WORKER) threads,
> > 2. Have their OS cpuset/affinity etc. managed by DPDK.
> >=20
> > Such functions would probably need to take <lcore_id> and <cpu_ids> par=
ameters, for dynamically updating the list of DPDK managed lcores and CPUs =
at runtime.
> >=20
> > Maybe the ability to dynamically manipulate the <lcore_id>@<cpu_ids> ma=
pping could be a separate set of APIs, so rte_thread_create_eal() would not=
 require those parameters. (Don't know, just brainstorming.)
> >=20
> >=20
> > Reason for asking:
> >=20
> > Because DPDK doesn't provide this feature (hot-plug/remove of EAL threa=
ds), Grout has to take on the task of performing its own thread management =
(OS cpuset/affinity etc.), register its fastpath threads as Non-EAL threads=
, and cannot use RTE_LCORE_FOREACH_WORKER()/rte_lcore_is_enabled() for them=
, but considers Non-EAL as fastpath threads.
> >=20
> >=20
> > Generally it would be logical for an application to register its contro=
l plane threads as Non-EAL threads to get the benefits that come with a val=
id lcore_id. But how then can DPDK discriminate between control plane and f=
astpath threads? Only the application knows.
> >=20
> > It would be nice if DPDK's perception of which threads are fastpath or =
control plane was aligned with the application's perception.
> >  =20
>=20
> I've thought a bit about this in the past, and come to the conclusion tha=
t,
> as currently designed, DPDK doesn't support spawning thread instances, but
> it instead supports the idea of spawning work on already-existing threads.
> I believe the original intention was that the maximum number of threads
> would always exist when DPDK was running, but that they would be stopped
> and started by the app by assigning them work - the threads being asleep =
in
> the kernel in the meantime.
>=20
> While it would be possible to make that model work for most use cases, I =
do
> agree that your suggestion is a reasonable one, and probably is easier for
> apps to work with.
>=20
> /Bruce

Also doing spawning of new threads doesn't work well with isolated cpus and=
/or cgroups.
You really want isolated CPU's with DPDK's polling model and that set is not
easily controllable. You need to use cgroups but also need to force a bunch
of other things like kthreads, RCU callbacks, and IRQs away from that CPU.
