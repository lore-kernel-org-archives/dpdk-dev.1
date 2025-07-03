Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EAC83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 14:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F27244042C;
	Thu,  3 Jul 2025 16:10:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D627240287
 for <dev@dpdk.org>; Thu,  3 Jul 2025 16:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751551801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpmQagpT9F6BDEFu1JCK6TV9SNXBZycrTWc3Q/VDOFg=;
 b=WE9WHrwXJkxeDtZVn0Mz83CD+tR//jiDjIVIEFPVyU8uIC+Ph9sq8z5EwHENheZDcvYDqs
 5RVs+2uVQ/mp8uqZ/9xWcZnfJWP9pp8kU4WIUwj/2O0mIriB7HRmOLtzYLZw5kKVQZCNKG
 hTwzGOj5Lspos+34R0e6g3vhMCGBDF0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-QlRpdnffN021xZ-tCGW-dA-1; Thu, 03 Jul 2025 10:09:59 -0400
X-MC-Unique: QlRpdnffN021xZ-tCGW-dA-1
X-Mimecast-MFC-AGG-ID: QlRpdnffN021xZ-tCGW-dA_1751551798
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-553cd66fbd8so4112252e87.2
 for <dev@dpdk.org>; Thu, 03 Jul 2025 07:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751551798; x=1752156598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpmQagpT9F6BDEFu1JCK6TV9SNXBZycrTWc3Q/VDOFg=;
 b=eNPvyBiFLM12/AjgIXsGjew9/UGOUBDZiYSEUlCTOzB8jngBCYwX2puE3fMaT/qTCa
 f26j3OuUBc3XAmyRNzClhLYKbM/DMbOhcLsnjPaNfrR6zB03aWPjpnrD2K9ZpC3g/9HE
 oeqY+vO8ouR2r3/Lul/vdTLbt8ua9YcoGhHApYewMrwUpzQy5OmJS4iUowt6Svjvz0i0
 G4hpOQ8LN8IsocMcP9iTumtyYS9g6WmoWxSzzxxhcGM7XiW1l+04dNJa2LfNGaRHUmb0
 2VkA2CgO7V89CE5WT96Iulqe1kHzV3a4mmfY3do6ZnnnlUWmxdDCvVUV4qq9jmymj3GC
 4NGQ==
X-Gm-Message-State: AOJu0YwMtajrdXNptupdHs5vuZZyN3Q99scuDTRU3cQEGY7mfx5AWRoV
 oCHKtSk/cXZWY7L5EJm3wx84G7wLqfXdLVNG+cT3/Zq9VMFHND4lzgSXFQrIcvbg1kRKgZFyw9n
 aNRkEW4sgUA+ciP0hL1eIy46q9UnT2+U+9MfardRoEfRLZv7uc7dneaPpYon6VoFWAulfQK4wSb
 sEjIxlhwNCa1MrTJhn688=
X-Gm-Gg: ASbGncv/ptVij/f1fCq1sW7Rjqu+J9wLtyP9FiHWXrY+z2HcW3Xu88cZBHFutNC6pPT
 ARXGBSecUF7zkrr90kEMUwjiKjtt282GpdSSk8Wc3QLmrD2dCq1YGU/cRE+14txUTuzK7BhEKaC
 TdtFu8mw==
X-Received: by 2002:a05:6512:3b2b:b0:545:225d:6463 with SMTP id
 2adb3069b0e04-556309ecb53mr1083143e87.42.1751551796229; 
 Thu, 03 Jul 2025 07:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHblULOrDBEYkkUyLFj0DrmtTieXqkI5e9Apko7qxzzv4T/A6MuAxrQ5hbrbaTYAnZKWj1OXcOZ1cChJczP6ko=
X-Received: by 2002:a05:6512:3b2b:b0:545:225d:6463 with SMTP id
 2adb3069b0e04-556309ecb53mr1083110e87.42.1751551795469; Thu, 03 Jul 2025
 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-3-david.marchand@redhat.com>
 <08ce2412f18d477199d3e02fdcf9bcd4@huawei.com>
 <CAJFAV8wb9ec_O2Dj8vX8YF9ksXzSDgCGefCaNEFs7HfeKhWjMA@mail.gmail.com>
 <afe059471e604b5c9319cb7312e69c23@huawei.com>
In-Reply-To: <afe059471e604b5c9319cb7312e69c23@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 16:09:43 +0200
X-Gm-Features: Ac12FXyFYkb2LzpJ29vyAUx-ZNZS0hTmj30FYFVzX2QkpvJFH6NsIsuLK2SX36I
Message-ID: <CAJFAV8xryLsxkLJMCDT5-o4s2-fMU5G2bcX066WEXaT=aXQG6Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] test/telemetry: fix test calling all commands
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6QInVlcRrzjTdB52CMaYixE3afMRmBWPCR5eC4xeD98_1751551798
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

On Thu, Jun 26, 2025 at 11:53=E2=80=AFAM Marat Khalili <marat.khalili@huawe=
i.com> wrote:
> > @@ -15,7 +15,7 @@ call_all_telemetry() {
> >      telemetry_script=3D$rootdir/usertools/dpdk-telemetry.py
> >      echo >$tmpoutput
> >      echo "Telemetry commands log:" >>$tmpoutput
> > -    for cmd in $(echo / | $telemetry_script | jq -r '.["/"][]')
> > +    echo / | $telemetry_script | jq -r '.["/"][]' | while read cmd
> >      do
> >          for input in $cmd $cmd,0 $cmd,z
> >          do
> > @@ -25,4 +25,5 @@ call_all_telemetry() {
> >      done
> >  }
> >
> > -(sleep 1 && call_all_telemetry && echo quit) | $@
> > +! set -o | grep -q pipefail || set -o pipefail
> > +(set -e; ! set -o | grep -q pipefail || set -o pipefail; sleep 1 &&
> > call_all_telemetry && echo quit) | $@
>
> I 100% agree with the idea, but sadly I'm not familiar with shell scripti=
ng enough to suggest or review this diff. Is `for cmd in` always equivalent=
 to `while read cmd`? Is CI ever executing it in bash for our attempt to se=
t pipefail to be justified? Is it idiomatic? I hope someone else here can h=
elp with this.

- From my experiment, the difference between 'for cmd in $(xxx)' and
'xxx | while read cmd' is that an error is not propagated in the
former case.

I suppose it has to do with the for loop, as described in POSIX:
"""
Exit Status

If there is at least one item in the list of items, the exit status of
a for command shall be the exit status of the last compound-list
executed. If there are no items, the exit status shall be zero.
"""

On error of the command, there is no item in the list of the for loop,
so the loop is overall evaluated as a success.


- As far as the CI is concened, the unit tests are run on various
distributions, including Fedora at UNH.
Since the default shell for Fedora is bash, then an error would be caught t=
here.


>
> Perhaps this should just be re-written in Python. It depends on a Python =
script anyway.

Maybe.
Though if we go that way, we would need some refactoring of the
telemetry client script, defining some python class etc...


--=20
David Marchand

