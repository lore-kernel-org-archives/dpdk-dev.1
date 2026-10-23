Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D7606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NZEebC+K
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9662E40299;
	Fri, 23 Oct 2026 14:49:55 +0200 (CEST)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) by mails.dpdk.org (Postfix) with ESMTP id 0412E40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 14:49:53 +0200 (CEST)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so882381d50.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 05:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792759793; cv=none;
 d=google.com; s=arc-20260327;
 b=JSw0xO4kuPIKZBkCBdV6tJGdamKdsOrutIYrK7UJFqRMGyEx5TG9hglsdoLBnZAZ/f
 AbRgsLy3ZU8U9xxeY5uCNhGXqVWIOmEIHsVW62fQZWkWcA+oEaSvsOdyBWeTzqQ7lua5
 dbhCr7kdStuxLVsj+vxu077zWSQV8XhN0P6686Ml3M0kLN7kk9yiM1bwipGCFio1/9Rr
 OIi06o/b/bvh3vbH5zD/IZIU6srCEtIjkRCVYukyHt71NuiJLYJ/ZylTeUsIJGoot6+z
 pqYeq/PMq15sNa9tR7KzeQaqq7kMohWJvfLKXdn815QkjZkZbBETafCfKVEdVzmNWyGI
 amTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pxwT95FhNvPJFYJfYVQ0udbFoT+dLQPhgTDT0SJbHUg=;
 fh=4HbLNzyl48uJ9zxGHkimalFDEtNLpGWqPQeXqYIemJI=;
 b=pK8XgXC5Y3uAgJOIu6B2eOE7g9O1IeGgFZ+cj3BC+DkkshQIcydPJgfgt3lz5Y970N
 M2KRsO6Rk8gy2o3Kd39sSH2As1Kg3U2hrzcMN9U062xTdkjDyawCORGu+cPZZlDVUmlS
 Ob/vBKBRbczrpQyYrx8IvZexzXi1ej4VujNy9A/hKrCUg64J6MVbc4bq9KGAXMR90akK
 Pjd3bD+QrYTXA23BuzAU4IA3IruS5GdbaH1hIgl8tjJEexSgzjpoPqgkV6r/67j7q+id
 pyHwaw7ZKRuj+7X51gOjywgzD3Iytn6DcoTdQ3aB+WNE2FKCnnBrwLWjcH+vlVmPdqZp
 QUpA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792759793; x=1793364593; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pxwT95FhNvPJFYJfYVQ0udbFoT+dLQPhgTDT0SJbHUg=;
 b=NZEebC+KiqN2X52MEZLURNt/npIyklexrYsWeFAgthsxCEWkQGb8vC2Wjz3ybsED9C
 eX0ShtiZSn0/UoPB9m2Y+xSBHDBiE/Q1WRi7VYwSclPWyFdjpiupMLWPvFUSQx5wnYQM
 EfGS3ie2E+hTDpI/e4E/yxa3UGNWuLG8uDK2dffyHuCkkfjlZDymStTb5YzuLzasiG2P
 +5b2JGCNhSb0Hxo3qh6UbCDohyv9V9LF+9O2CsfunFaeJhWibl9mYiz+47x+XdizSWwe
 S71inMdDMQVm1P56lDCyE0Hy0gnmtRjsfXAj4geYZF2hWvGAN0rqB6rfjxUdUkFNDvM9
 oMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792759793; x=1793364593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pxwT95FhNvPJFYJfYVQ0udbFoT+dLQPhgTDT0SJbHUg=;
 b=utZfLuZ5v2RCSeuMWKQhTjUt2oZ6qJ8ZFS8IPOOh0DhAR1Yyb6+2ceWrp5Y2yZ/BMC
 i6CSJubfDhE0pMz0OgS8rNVaCIPmqfcPpdbCtdmObEYA8bOZzCfhK7ysWfvxlZp8IlJL
 WcwA+/sbmaU4e1Fs68rhgP6PBMw2Sw9jDNtFAJfk4mCYkDFrvUCD7oLDUFZVJ4uFynJz
 KDtVPkU9mzeDvr13gceenrGK2icIeFu3HoQmu/85SXyqINgvD8GD39jzM/Jf/S8AAxjl
 C9ie2Kl8W2NZHF0MC+7ge/dERo8eZbaO3qRAlQ8GGzZHeF/iSEoO6znR6CvUep3ACh25
 +9ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwM/dGc5g18ogJ/bP2ZM5zbNaGe5PtZHqwMb/2HCXU31y7aS4UqWN2Oq+MNBXcpgDsnXnM=@dpdk.org
X-Gm-Message-State: AFq9FYL0DRxEY5KoBKY9o6kAKuH3MqXjGw7o6D6xpDDQqhTuFFW9WVzm
 R2oeXFTOXjAf01DiaB2JRNCUjzmJ5PoiWVwU7V5eA0vJ++r/9Ry2ubjCvKa4dGtXj+K3JmH2aml
 JTFf7PXIj7zVufGvcl7pjpd/sujpi2DwMi+TU
X-Gm-Gg: AYBFou2z05cBKFLQVg3dFQI3ynXlKsmlOe/zyte3AYBpwOUndxIuiY0b1IcOtn2RZwI
 0CqjDorOi+ak78RCaDaaMtQyeEhcxrHXns1ahsNo4HCb6xtyPanXaX5Ue/Kv09wupfLNgVe+RlF
 wD0NgbzOmuZBOh/fWv0B0jkBrgxzA++TuInbuNaXQWKkMALY95ZrrgApEysjLajz3veC0oBh6Kd
 Oyovv98hsqNzAOv5WMb0z7uCQZV3XZ0WypUhesh1L99ThvuN/V5Z54rMiEsN5PNYft/MHqn/SlA
 /q05i8xcovjmEgH6h8tai0qcd1Vh4A5TZFSDoznBL94yLckej1Yy2VL0YGSaUKlcPWw37HWceOM
 VdYv+cWMIaD4d2bOcpyfPEU16awFbVVPuwiLskPQGAIhpFDgrZ4UpKUjpqRjIDuOlwOZXxRhuXK
 cGSvc/oTa5Fd+tIUOaQI43p1SeL0kprsJwpnROwuJoB7e3lUJxVJQ4nGgmoDsFqBlMFhWuWXRZv
 w==
X-Received: by 2002:a05:690e:d47:b0:679:b9ad:d644 with SMTP id
 956f58d0204a3-67a35cca889mr1135987d50.95.1792759793216; Fri, 23 Oct 2026
 05:49:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
 <SA1PR11MB68060466B72DD59668D2890690652@SA1PR11MB6806.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB68060466B72DD59668D2890690652@SA1PR11MB6806.namprd11.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 23 Oct 2026 18:19:26 +0530
X-Gm-Features: AclHuK_CFIyUQgGVq6UK8538zfLEwRV84NJKwgpQiyLfwOP8UWBlI0uI4ctQlNQ
Message-ID: <CALBAE1MBsUr5jchFXmht5ymzwgU5CgW4DEa1ZL2DvGdtcue61g@mail.gmail.com>
Subject: Re: [PATCH v1] event/dlb2: race condition during dynamic linking
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Cc: Pravin Pathak <pravinpathakdev@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "jerinj@marvell.com" <jerinj@marvell.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>, 
 "pravin.pathak.dev@gmail.com" <pravin.pathak.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 4:14=E2=80=AFAM Sarkar, Tirthendu
<tirthendu.sarkar@intel.com> wrote:
>
> On Wed, Oct 21, 2026 at 01:20:41PM -0400, Pravin Pathak wrote:
> > dlb2 handles dynamic linking and linking asynchronously if queues
> > being linked/unlinked have traffic. [...]
>
> Fixes: 5433956d5185 ("event/dlb2: add eventdev probe")
> Cc: stable@dpdk.org
>
> Acked-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> Tested-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>
> Thanks Pravin. Confirmed on DLB 2.5: without this patch, runtime
> unlink/relink under traffic stalls on all ports once the worker exits
> before worker_launched is set.
>
> Jerin, please add the Fixes/Cc tags when applying.


# Fix the author to Pravin Pathak <pravin.pathak.dev@gmail.com> - Use
.mailmap email
# Changed if (ret) to if (ret !=3D 0)
# Updated as

commit 2631abb3e2cbad9beb3d5710fd9fd482b18b6f25 (HEAD -> for-main,
origin/for-main, origin/HEAD)
Author: Pravin Pathak <pravin.pathak.dev@gmail.com>
Date:   Wed Oct 21 13:20:41 2026 -0400

    event/dlb2: fix race condition during dynamic linking

    dlb2 handles dynamic linking and linking asynchronously if queues
    being linked/unlinked have traffic. It starts a thread if not already
    started to handle the process. This change avoids the race condition
    in thread creation where sometimes the thread starts immediately,
    descheduling the calling thread and finishes the job and exits, and the=
n
    caller sets worker launched true when the thread is not running.

    Fixes: 5433956d5185 ("event/dlb2: add eventdev probe")
    Cc: stable@dpdk.org

    Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
    Acked-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
    Acked-by: Bruce Richardson <bruce.richardson@intel.com>
    Tested-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>



Applied to dpdk-next-eventdev/for-main. Thanks

@Thomas Monjalon Please pull this patch for event-dev tree, if you are
already pulled the tree.


>
>
> Regards
> Tirthendu
