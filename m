Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAD606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iwJnmZnD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 273BC40659;
	Fri, 23 Oct 2026 17:08:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 16E1B40265
 for <dev@dpdk.org>; Fri, 23 Oct 2026 17:08:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792768131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZGmWIkD9xRI7yRnfGi49QjsCIbAyJKJT1NBDwgy8qM=;
 b=iwJnmZnDcvgCDadtvAKr/yboEFOArsJFIGEFwhr5eVLUnOiGuyLzy92jhR7GvYXgDiRX0Y
 AYWGaCRb0dPL4ZYJlR9FF/z2i46BTLCiRw4FZ0xIyeWV+tBOCbudsjcgqKxLAz4n20ltca
 8VJ5pIRBZWYx0VjA0vjO1lLv0IF06X8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-KGYSMs-EOIyV53r_M72Wpg-1; Fri, 23 Oct 2026 11:08:49 -0400
X-MC-Unique: KGYSMs-EOIyV53r_M72Wpg-1
X-Mimecast-MFC-AGG-ID: KGYSMs-EOIyV53r_M72Wpg_1792768128
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3ab2cf30ab5so5951191fa.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792768128; x=1793372928;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DZGmWIkD9xRI7yRnfGi49QjsCIbAyJKJT1NBDwgy8qM=;
 b=UAtujytUeT3xoO3uILGJqOd82W4NsDV437fgqAsX1pW2g3oQOYIKSYRSzRE7SEtakr
 7D9zAuFOsB+7k7+7GwJcyx5h02PIiKctDn2/+AYFAIbpvYhEb2QoQaRmA2NEEQcTaKMN
 tqrmO2k3NR8z5mh6GNmfVmtGrlWxzWNOOCynZofbzH2rjVvqtbl//KN7xAHbygiE8qpb
 488AO6CzZgmjj8hQSXUsost44RaJUk3Sg1kuFCASqDLhBMBjW0bBcEUW9gK4DgtEV3jI
 44zuvsCaC14DZ3KvZbbk1GvI0WTcZSZCVgyq5/VO+5TaBdnv8SFCfDoygn/wC6sEArE+
 rYcQ==
X-Gm-Message-State: AFq9FYIPiHY31kJZEV4iuxGoA1yCcX3q27UESu8OGUF2vnSBtNjj2ohj
 23r6bDT0sdGCIj3MfFu4eorwiGIUZw2njwoiKISdLF2SgctEyoYt8RrX1ZLxgD57ulS2oJsw7Rc
 omcMRk81U0C0S0E35LTu8+H/iRtoQbcaiRdRlqjFVD79iuKakQVBrVQEKYzEXdUpR9WhQ86ehow
 kqQGi5iA3fi/aWov5cBic=
X-Gm-Gg: AYBFou0wjyskgU2Wd882QhEQUWo7u2ZR46PHR9JNS3ZE4OM9HVsQH07fcTfHHnnBS91
 5SQZlLd/LHrfhyNbEl4ZAs7mTB8eKjfCtKVtQTP+awM+NRICsk8Su+CUQThjJ3WNyeSb0w9oYWV
 A5GccH4sKTSAgdSGtLSMxJVyOz4cYv//ErSlF5qVH/tJFmsSF49t7LXFRLJQ+zhtigRdNcn6FAd
 k6IxZGgQNmhF4TrtFX+fXProY323/vqCrDtKMitzykXqKz8
X-Received: by 2002:a05:651c:210e:b0:3a9:abd6:1acd with SMTP id
 38308e7fff4ca-3ac663169f0mr6988601fa.6.1792768128131; 
 Fri, 23 Oct 2026 08:08:48 -0700 (PDT)
X-Received: by 2002:a05:651c:210e:b0:3a9:abd6:1acd with SMTP id
 38308e7fff4ca-3ac663169f0mr6988531fa.6.1792768127679; Fri, 23 Oct 2026
 08:08:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
 <20261022174447.412638-5-david.marchand@redhat.com>
 <nGkyRUDCTUiARwHHOBzhIw@monjalon.net>
In-Reply-To: <nGkyRUDCTUiARwHHOBzhIw@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 17:08:36 +0200
X-Gm-Features: AclHuK-uTm1D7mzp3X_3pUPl7fx03xpqyuJy6_7UHoTRy7WQitbJ-FJ9rDsFVlo
Message-ID: <CAJFAV8xfv+SckPeVVY+YwgeWO9N0RCp6C5PZ-OOQYFnp5i8d_g@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] devtools: handle multiple drivers in doc check
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZFxnNx-X5oKIKasfR8LOcOH7SmpS_kkLsJ-2YaCCMcQ_1792768128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 12:13, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 22/10/2026 19:44, David Marchand:
> > -     report=$($selfdir/parse-flow-support.sh $code $doc)
> > +     code_support=$($selfdir/parse-flow-support.sh $code)
> > +     report=$(
> > +             for category in item action; do
> > +                     section="rte_flow ${category}s]"
> > +                     code_items=$(echo "$code_support" | sed -n "/$section/,/]/p" |
> > +                             sed '/]/d' |        # ignore section title
> > +                             sed 's, *=.*,,' |   # keep only item name
> > +                             sed '/^$/d' |       # remove empty lines
> > +                             sort -u)
>
> This parsing is used below.
> This is an opportunity for a function.

I prepared this:

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 4c45bc0bba..9fc14dd19e 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -118,6 +118,14 @@ items_not_in() # <list1> <list2>
        } | sort | uniq -u
 }

+parse_rte_flow_section() # <section>
+{
+       sed -n "/$1/,/]/p" |
+       sed '/]/d' |        # ignore section title
+       sed 's, *=.*,,' |   # keep only item name
+       sed '/^$/d'         # remove empty lines
+}
+
 check_rte_flow() # <driver>
 {
        code=$(driver_code_dir $1)
@@ -128,15 +136,10 @@ check_rte_flow() # <driver>
        report=$(
                for category in item action; do
                        section="rte_flow ${category}s]"
-                       code_items=$(echo "$code_support" | sed -n
"/$section/,/]/p" |
-                               sed '/]/d' |        # ignore section title
-                               sed 's, *=.*,,' |   # keep only item name
-                               sed '/^$/d' |       # remove empty lines
+                       code_items=$(echo "$code_support" |
+                               parse_rte_flow_section "$section" |
                                sort -u)
-                       doc_items=$(sed -n "/$section/,/]/p" "$doc" |
-                               sed '/]/d' |        # ignore section title
-                               sed 's, *=.*,,' |   # keep only item name
-                               sed '/^$/d' |       # remove empty lines
+                       doc_items=$(parse_rte_flow_section "$section" < $doc |
                                sort -u)
                        {
                                # items documented but not in code
@@ -145,10 +148,7 @@ check_rte_flow() # <driver>
                                all_doc_items=$(
                                        for drv in $(docs_for_code $code); do

d=$rootdir/doc/guides/nics/features/$drv.ini
-                                               sed -n "/$section/,/]/p" "$d" |
-                                                       sed '/]/d' |
     # ignore section title
-                                                       sed 's,
*=.*,,' |   # keep only item name
-                                                       sed '/^$/d'
     # remove empty lines
+                                               parse_rte_flow_section
"$section" < $d
                                        done | sort -u
                                )
                                items_not_in "$code_items" "$all_doc_items"


I'll wait a bit for more reviews on the rest of the series.


-- 
David Marchand

