Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FAAC7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:32:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83712402AE;
	Thu, 26 Jun 2025 10:32:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0CDDC40287
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750926768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8eDx9uS33v1vJ5M02TsIFt5yZiltZW6LrOmCWNH0wA=;
 b=Rc2WYAH0djdfPM8HCTx9OEnr+GjrX/tZY4bIFqgYUPjUW1Z6uuK7enOn1yayyH9kL9+hOn
 tVP2gXxvLPDYvx/oChMmWjXFJXekK1rJnVqteWWZGNVLmWRuN9ev4fIGrOxfu9JuG2WXPt
 LI9kOKQ1hobSx71EzLLTvtIcbPbBpKA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-xNRuTKePNu6aALXVQTh47A-1; Thu, 26 Jun 2025 04:32:47 -0400
X-MC-Unique: xNRuTKePNu6aALXVQTh47A-1
X-Mimecast-MFC-AGG-ID: xNRuTKePNu6aALXVQTh47A_1750926765
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553acdcd5a1so363481e87.2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 01:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750926765; x=1751531565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8eDx9uS33v1vJ5M02TsIFt5yZiltZW6LrOmCWNH0wA=;
 b=Lp2zF+zLOuWbcJyVLEnJYm2lZIoi3Dt2MZ14z14i5pDPASHxwqjlpBijEpJ+KPqeZ+
 dX3PyslCiXR4TPd5gQdXkv7VGbHHAhjAbsDfDgPNKKYdcDuvjp3n5vbOxXf8gAIUHVjj
 0N5FfgFV0vHAvIkmXucqqcbVxXcIgPi1L9FbaDcXGs5s6Y1dhvUT8b51jl1/zHqgaZBs
 g7xw4utSfJBZUQR+IFXTy2Tj0UIOCIiRxKGB055GOqcQ8wFId3rcB0dXEscyuHpaae0m
 qOb8phvSIzyS4hy/OknyCZszx6q2lWBh+i8iJkshK2PLbIXqIrvrLCJtFCuputvw/VrB
 eDwA==
X-Gm-Message-State: AOJu0YwVe4gKzyWqAD7cSMyj3zYuncjZcCPzc3OVmfUy9mDwb5ECmC9a
 4fm9Z3lk4HEeCqaSBhbqu3SZfFukJZxqqqs9wmBScKzUwUooMBS3F4iVd73esCNTylTGzTpJ2PJ
 XKwhtMrad6qMx7Pkzqz5DmPYhzZVFvfkLIa9UJasjdvaxBqY9UL9H1HroWru5zn9P8TZrtdSUMH
 UN+eepcAYejOYaf6zOIOQ=
X-Gm-Gg: ASbGncvHiO1gWER2wSFgU5VKf79Hc1rXKrjty60iUdY48jgg5LI5AldqjVYImCQFMbu
 EnOUNJC9FFwGAP7o5o+TR5amS08J/fFB2KFplaQxP5K0zf6LEC4FdWjxCmUVQ9rvUBDCjR45ttn
 fw/bPBhQ==
X-Received: by 2002:a05:6512:3b89:b0:553:3770:c912 with SMTP id
 2adb3069b0e04-554fdfb1bb9mr2116346e87.47.1750926765227; 
 Thu, 26 Jun 2025 01:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ6A0fc+qZDlvYRLnUzZJhxctWHj8KMxYhevKe0aj99G4sthGEQGqsUz51+t+LyhzdsUal4NW50AqNR6fl2No=
X-Received: by 2002:a05:6512:3b89:b0:553:3770:c912 with SMTP id
 2adb3069b0e04-554fdfb1bb9mr2116340e87.47.1750926764771; Thu, 26 Jun 2025
 01:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-3-david.marchand@redhat.com>
 <08ce2412f18d477199d3e02fdcf9bcd4@huawei.com>
In-Reply-To: <08ce2412f18d477199d3e02fdcf9bcd4@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 26 Jun 2025 10:32:33 +0200
X-Gm-Features: Ac12FXyH7nQba201kn0CjUkjg1vmUro_aRwYoim9HG3AwrFt2BuPVodA9wtu2dE
Message-ID: <CAJFAV8wb9ec_O2Dj8vX8YF9ksXzSDgCGefCaNEFs7HfeKhWjMA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] test/telemetry: fix test calling all commands
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RCLTp005mGvibIxM4VnO3Ql6sMlcyaqESqFpM_NFBj4_1750926765
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

On Tue, Jun 24, 2025 at 6:00=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
>
> Just an idea, in case you have another iteration: could we maybe add a sm=
all check that $telemetry_script actually exists and executable to avoid si=
milar situations in the future? Can be as simple as:
>
> test -f "$telemetry_script"
> test -x "$telemetry_script"
>
> Due to -e in the first line it should fail the script of any of these tes=
ts fail.

The problem lies in the use of subshell and pipes and that a failure
is not propagated.
Adding a test only the the telemetry script would not catch other
errors (like for example, if the jq command starts to spew errors).

The most elegant would be to use errtrace and pipefail options, but
the errtrace is a bashism (iow not POSIX), and pipefail is POSIX only
since 2022 and many shell (like dash in Ubuntu 22.04/24.04) don't
implement it.

We could try something like:

diff --git a/app/test/suites/test_telemetry.sh
b/app/test/suites/test_telemetry.sh
index ca6abe266e..a81b4add90 100755
--- a/app/test/suites/test_telemetry.sh
+++ b/app/test/suites/test_telemetry.sh
@@ -15,7 +15,7 @@ call_all_telemetry() {
     telemetry_script=3D$rootdir/usertools/dpdk-telemetry.py
     echo >$tmpoutput
     echo "Telemetry commands log:" >>$tmpoutput
-    for cmd in $(echo / | $telemetry_script | jq -r '.["/"][]')
+    echo / | $telemetry_script | jq -r '.["/"][]' | while read cmd
     do
         for input in $cmd $cmd,0 $cmd,z
         do
@@ -25,4 +25,5 @@ call_all_telemetry() {
     done
 }

-(sleep 1 && call_all_telemetry && echo quit) | $@
+! set -o | grep -q pipefail || set -o pipefail
+(set -e; ! set -o | grep -q pipefail || set -o pipefail; sleep 1 &&
call_all_telemetry && echo quit) | $@



--=20
David Marchand

