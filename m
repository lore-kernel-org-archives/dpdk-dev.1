Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E626CA5FB3
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 08:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB77B4027A;
	Thu,  1 Oct 2026 10:19:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9781740144
 for <dev@dpdk.org>; Thu,  1 Oct 2026 10:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790842787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0M5siRnFKfDmvrsPNr51yjn0cIJKX0l9dPkgWKyqKE=;
 b=P5WmN7/5Cltl5raE6EC3/yyDU2XkcjyqjSvDiZH6ERnuOVtJtSe187230O1a2EY/qTJ3ly
 yIHWhhZP5MQVeffPDYQHgTi8M8K/rAb2x+cCivTvdKpWbRb4qg8o3lFCgkLsirSxLCpvfk
 xggluZ/yAHRHnfZcwfU/RmiiDklUo78=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-WN1PZz6fP7aLpEk-uVwS9w-1; Thu, 01 Oct 2026 04:19:45 -0400
X-MC-Unique: WN1PZz6fP7aLpEk-uVwS9w-1
X-Mimecast-MFC-AGG-ID: WN1PZz6fP7aLpEk-uVwS9w_1790842784
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a6689e0e8fso15577851fa.0
 for <dev@dpdk.org>; Thu, 01 Oct 2026 01:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842784; x=1791447584;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d0M5siRnFKfDmvrsPNr51yjn0cIJKX0l9dPkgWKyqKE=;
 b=DlhZbXQ7hke9jJoKeVP/oMEb61ZhHzqdMAe3kBd+6wG6tZQfsK2S5QBnqWN1SuJueo
 s0zS5HJ+jfVu8mWVB6u/5geBOT3nN6XACLyDI876ArbgbXsGAWsB9ypQ2dqoI1HBzB8U
 D2pHAaSImG6ZQ9hkzTUIVH+rOaUwOzzLjkzVY5Dp5ImwQQ5fyYAtfLjrmg+PzdLLbcOj
 2hOpD56lBLijyY+NIWnax3gEVUEnC8P23DHU3b3a4ydrXzcRvDsox2mDCls1qmx78EIN
 ybZ+isox02HuqEsyw5nsOg4W0f7PUeIBJCob3TOboPwtbDOl7uOouVtlT/1SqQEDDkHS
 Ti5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhfrmUdJKNe2QX6nMsV6FlsLkLaZLJtpggdhi7OmDJAcTjs7nDU9Ay37MhnDb460Njx+E=@dpdk.org
X-Gm-Message-State: AFq9FYLWw1CI4ho1l8BZ3burEdJPGdaGSK7t4y+RHeZ2mxRiDWHgcdAl
 W6rkuNNRdJvgkT3Ys1CPh3uUwCAFuQ5LU4dI9HH1gU90NYwNEymQp+alUcpjpbQkExMTg3a/Ueb
 reCLz08bp+6ts4xLJSXLl6EWPGh3tu+Yc2KdxfEWTgzhkLcZlkcD7PXrK6UNvkjprChzoovVk6J
 s/j3WKZ8qIFDbBSBzNlEw=
X-Gm-Gg: AYBFou3yCRR2bfyqIvA5IKi9S79jbnMEsbSwou4IU2mdNxXJlEH2bxOiQCwHuloMN89
 AybihMzPiQTHChuG4QUv8cvQL3RdLoaX7+UF6f8oqBL9eVwr3QJYKTqV1RMd/BIJ4iuV4uqEC+F
 LSpnRrFE9+UNUBQM85dentcTrsheI5Lrt3jOa3VYip3RWLp+TfBty/8LTTJPQ59ayjXejh4tQ9g
 P718ROohfs9RHk6xycI9iPkLHaTCm2PFJhqiafHjvG8JnQJ
X-Received: by 2002:a05:651c:1b96:b0:3a7:812b:d13 with SMTP id
 38308e7fff4ca-3a78325c0f0mr5544561fa.0.1790842783991; 
 Thu, 01 Oct 2026 01:19:43 -0700 (PDT)
X-Received: by 2002:a05:651c:1b96:b0:3a7:812b:d13 with SMTP id
 38308e7fff4ca-3a78325c0f0mr5544441fa.0.1790842783439; Thu, 01 Oct 2026
 01:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20260930095800.551314-2-maxime.coquelin@redhat.com>
 <20260930082638.0932a5e9@phoenix.local>
 <CAO55cszUi99k3vjKTQh31QArHxpq_65HK1sKS2AdTW4TzLSSwg@mail.gmail.com>
In-Reply-To: <CAO55cszUi99k3vjKTQh31QArHxpq_65HK1sKS2AdTW4TzLSSwg@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 1 Oct 2026 10:19:31 +0200
X-Gm-Features: AclHuK_whhS3sA6QglLFzT4hZNbwreUz8RVsT-Ih1WnFmLmxuuyLw1Fusuga_KA
Message-ID: <CAJFAV8xRTkAbOo-c5hp75ChtVJoLct4fh5jR4-rYZEU8u576WQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: add compatibility for old compilers with new
 UAPI headers
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 eperezma@redhat.com, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M1vylcdzY1WcwEf-FPyYASJIpvNKldz19BS26WSvz44_1790842784
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

On Wed, 30 Sept 2026 at 17:37, Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
> On Wed, Sep 30, 2026 at 5:26=E2=80=AFPM Stephen Hemminger <stephen@networ=
kplumber.org> wrote:
>>
>> On Wed, 30 Sep 2026 11:57:59 +0200
>> Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
>>
>> > This patch adds a compatibility define for __counted_by attribute,
>> > which is not present in older compilers but required for recent UAPI
>> > headers like vfio.h.
>> >
>> > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> > ---
>> >  config/rte_config.h | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/config/rte_config.h b/config/rte_config.h
>> > index 0447cdf2ad..307e7dac62 100644
>> > --- a/config/rte_config.h
>> > +++ b/config/rte_config.h
>> > @@ -25,6 +25,15 @@
>> >  #define RTE_TOOLCHAIN_MSVC 1
>> >  #endif
>> >
>> > +/*
>> > + * Compatibility define for Linux kernel UAPI headers that may use __=
counted_by
>> > + * attribute for bounds checking. This attribute is not understood by=
 userspace
>> > + * compilers, so define it as empty if not already provided.
>> > + */
>> > +#ifndef __counted_by
>> > +#define __counted_by(m)
>> > +#endif
>> > +
>> >  /* legacy defines */
>> >  #ifdef RTE_EXEC_ENV_LINUX
>> >  #define RTE_EXEC_ENV_LINUXAPP 1
>>
>> NAK this is best done by keeping up to date stddef over in virtio header=
s.
>
> This is for VFIO, not Virtio but that does not change the issue.
>
> Problem is importing stddef in UAPI as currently done, does not work,
> because the system version is included first so the imported one is disca=
rded.
>
> An alternative solution I tested would be to include the imported headers=
 first,
> but it means imported headers get silently intermixed, which worked in my=
 test
> but could lead to hard to debug issues.

I don't like the alternative, for the reason you listed, plus the fact
that this intermixing is invisible.
At the moment, using an imported uapi header is opt-in, and I prefer
it like this.


> While not ideal, the solution proposed in this patch is harmless, we are =
talking
> about an attribute defined as empty.

Your solution of wrapping __counted_by is simple.

On the other hand, fixing the existing import script would require
relying on an external tool (unifef), which could be acceptable.
I tried some:

diff --git a/devtools/linux-uapi.sh b/devtools/linux-uapi.sh
index dbf3163bc8..189164928c 100755
--- a/devtools/linux-uapi.sh
+++ b/devtools/linux-uapi.sh
@@ -13,6 +13,9 @@ file=3D""
 check_headers=3Dfalse
 quiet=3Dfalse

+# Require unifdef
+unifdef -h 2>&1 >/dev/null || { echo "This script requires unifdef."; exit=
 1; }
+
 print_usage()
 {
        echo "Usage: $(basename $0) [-h] [-i FILE] [-u VERSION] [-c] [-q]"
@@ -85,6 +88,9 @@ fixup_includes()
        sed -i 's|#\(define\)[[:space:]]*_UAPI|#\1 |' $path
        sed -i 's|#\(endif[[:space:]]*/[*]\)[[:space:]]*_UAPI|#\1 |' $path

+       unifdef -U__KERNEL__ -D__EXPORTED_HEADERS__ -o ${path}.tmp
$path || [ $? -lt 2 ]
+       mv -f ${path}.tmp $path
+
        # Prepend include path with "uapi/" if the header is imported
        for include in $(sed -ne 's/^#include <\(.*\)>$/\1/p' $path); do
                if [ -f "$base_path$include" ]; then
diff --git a/doc/guides/contributing/linux_uapi.rst
b/doc/guides/contributing/linux_uapi.rst
index b8febfc420..a3490bfbb6 100644
--- a/doc/guides/contributing/linux_uapi.rst
+++ b/doc/guides/contributing/linux_uapi.rst
@@ -27,6 +27,8 @@ Importing or updating an uAPI header file
 To ensure that imported uAPI headers are unmodified
 and sourced from an official Linux kernel release,
 a helper script is provided and must be used.
+This script requires the ``unifdef`` tool.
+
 Below is an example to import ``linux/vduse.h`` file from Linux ``v6.10``:

 .. code-block:: console


Then imported linux/types.h, linux/posix_types.h and linux/stddef.h.

And net/nbl needs some fixing... as it includes uapi/linux/vfio.h too late.=
..
Only occurence in the whole DPDK tree:
$ git grep -l '# *include.*uapi' :^devtools/linux-uapi.sh
:^doc/guides/contributing/linux_uapi.rst | while read file; do [ $(git
grep -B100 '# *include.*uapi' $file | grep '# *include' | wc -l) =3D 1 ]
|| echo $file; done
drivers/net/nbl/nbl_common/nbl_userdev.c


--=20
David Marchand

