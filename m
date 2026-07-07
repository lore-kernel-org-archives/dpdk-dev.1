Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4082C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11C9440264;
	Tue,  7 Jul 2026 13:42:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D9A1E4025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783424531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EywC9HtSRepm5s5ZYh5IhiSYmnQzHOJD0WiUztHmJrg=;
 b=XxuW5zfCAZsauvGdmIwu2nxJ7lZP2RDkmdsGyssQh7J23goE11XlC0YT2LS238ZGB8uGSI
 vs1rSTyTtsQ78kSSPTTaBLBjlrsngXRz+0aikPCWfXzW7n1M2KcjylPLttjA4mUSIInd3m
 TJhlvcklIu4VvAU6QIOiMLYrNUKlMYA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-6ZmNFaL3NO2-N0JVzfgzZA-1; Tue, 07 Jul 2026 07:42:10 -0400
X-MC-Unique: 6ZmNFaL3NO2-N0JVzfgzZA-1
X-Mimecast-MFC-AGG-ID: 6ZmNFaL3NO2-N0JVzfgzZA_1783424529
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39accc98fffso16231521fa.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 04:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424528; x=1784029328;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EywC9HtSRepm5s5ZYh5IhiSYmnQzHOJD0WiUztHmJrg=;
 b=i4qNFstXnE0Lloqw55m4ZvwqgAVvsO/JuauOj608igZkNqHO0AkWJKhGHI6n+a8snE
 vV4Ty8edMzxST3wxypxf/dOgCo8TZxXwlMv/UhIlOTaJv3NA5D5vsBKOUrqWPcq5CcWj
 VirJNv7oDbk29P+TvjsE4WkRXOVuXJoeKmpugTLMo26vb6vA4DKN6riDvilNcYf0qwfV
 a4RLYNfuhjjEgE7lGVmUDvL/0mX9LyOMpKRAmGcdLUPS9fjN5UIgQ8n5AODCnPHmkuXS
 Ay1KPY0Pq1nnDcTaA0rDad6D4DCY3nQ5N5qGUAGR2M2SOaHhI7teiKEk2n34qTBcir60
 kHtQ==
X-Gm-Message-State: AOJu0YwAB5IVqsiiN9Uads1aLkdbepezFnwX5NJHkOFaidkjNOXWKIIx
 OOPKMtoqB93uFS9fC7TFMowkUymUrWCiGkT8cPt6eqYP7chiipGCFPDWPtIx/gE8NXi4A8heVK6
 lJf+aCL6wblAXm3AYc7l21YQFITy6jK+lAtqYG2/oxRkPlaIYCpP4LvKL/zbZ79ybeJIE3OqWpT
 GjWdZYJJPMvhELLUVNMP7WU1O9440=
X-Gm-Gg: AfdE7clijcSX7QChSo4stJzKt40Byj2KpNK1Tc/uSd+3XSAFj2CByOWS+cj+jmIZl3u
 2UyvViwPV2l4YzJRp6V/JELnIuT0LQy0zy4iKCmkUTZGzzWjsE9x7iz6qEkSwR4qNgpk87z0UAe
 XZV7WcHWtZWkV5vziqHO+UZA+akpral3jukOffELukqZaCtcqQECghcSBo1whgFHYDWQD6KoQj/
 ZopJVIuZEEzzFuX975rN9K/EQP8wXpVt+hCvnjJB19QjzC39E45+qFlFu8=
X-Received: by 2002:a2e:9884:0:b0:39b:90f:b1e7 with SMTP id
 38308e7fff4ca-39c5fd378famr8565151fa.10.1783424528034; 
 Tue, 07 Jul 2026 04:42:08 -0700 (PDT)
X-Received: by 2002:a2e:9884:0:b0:39b:90f:b1e7 with SMTP id
 38308e7fff4ca-39c5fd378famr8565101fa.10.1783424527411; Tue, 07 Jul 2026
 04:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260706145510.680077-1-david.marchand@redhat.com>
In-Reply-To: <20260706145510.680077-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 7 Jul 2026 13:41:54 +0200
X-Gm-Features: AVVi8Cc5lNdXp0xuJyt9rizPEzu7NJpwxJBtkYLnzAgjqIloVUmwNSqbjL4j2Wc
Message-ID: <CAJFAV8x8g+NcpjD+u_aKhqGWTPz1c+b9qQ0xaqTiVj6kqsUFsw@mail.gmail.com>
Subject: Re: [PATCH] dev: fix hotplug notification to secondary
To: dev@dpdk.org
Cc: fengchengwen@huawei.com, Thomas Monjalon <thomas@monjalon.net>, 
 Anatoly Burakov <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SIIA8lzo70wz8fgEPIcgYr353nz0PY8MW6arBkpvRhI_1783424529
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

On Mon, 6 Jul 2026 at 16:55, David Marchand <david.marchand@redhat.com> wrote:
>
> There was a logical error when making some last minute change.
> Fix the no_shconf evaluation.
>
> Besides, we currently have no unit test checking device hotplug in the
> fast-tests testsuite.
> Instead, we rely on rcX tags validations when non regression tests
> relying on the multiprocess examples are run.
>
> Add some basic unit test that does not cover all that the examples do
> yet provide a first gate on multiprocess changes.
>
> Bugzilla ID: 1963
> Fixes: 1a2e26d8701d ("dev: skip multi-process in hotplug")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

There are some issues with the added test.

The new test is failing on LoongArch CI.
LoongArch CI seems to have a list of excluded tests, and it excludes
multiprocess related tests.
So I guess I'll need LoongArch people to update their tests.

I also have a build issue when disabling net/null.

The AI bot also pointed out some leak in the test exit/error paths.

So I'll send a v2, but I'll separate the EAL fix from the unit test so
that I can merge the fix quickly.


-- 
David Marchand

