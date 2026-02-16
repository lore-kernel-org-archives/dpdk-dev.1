Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC19E81A2E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 14:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B9A940289;
	Mon, 16 Feb 2026 15:49:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B53ED40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771253350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8D+PVuhcJBZrR6HWPoAE+2jeXcaFRnkI+mVNDAxBpRo=;
 b=V17yaZ3kVgCf9lvgO5F4AsDbdNPVjVPTf726H3ED/T56RWaGON9HMInQklo6DLgNdTpgp/
 8YQXvbCKO+/K/lVe3u59Fpyf57ubBxaujgSMIBFqmEn7UrwOKxscJr0Ri7i7q79lfsYc/G
 lhluPftpR0L9aq0+eydJ1qjhModsQ8w=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-lfizPbycOVCNzfw1H1yW-A-1; Mon, 16 Feb 2026 09:49:08 -0500
X-MC-Unique: lfizPbycOVCNzfw1H1yW-A-1
X-Mimecast-MFC-AGG-ID: lfizPbycOVCNzfw1H1yW-A_1771253347
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-385bb7f429cso19621431fa.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 06:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771253347; x=1771858147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D+PVuhcJBZrR6HWPoAE+2jeXcaFRnkI+mVNDAxBpRo=;
 b=UgDiUqjqFJkfAbXi7WT0h1pqNmVG9n0HKBwQ1csVT9ErrBUUNEWIEtfVwdoKVvEGGi
 jwghTYfuIKxNdcqG5v0jotmzrSdhT31UQSy4SqV+q+h0kYng2e2twzm/v38EN08KbrNH
 6idYfgpj0dWgdA65wI+Qn4WiQvAgXHByvMZHbuKJtLs8kbpWFtHgoZwA2BYEr9om6Y43
 5cGqNfzIVmKlfM93kcs3SWIdaQO6T/n8oOXyD3zyhplaEyao+zNdKQWVtAn2cZfTKqak
 n3gnyv8zsJKQIWDCUqLkgk8nL/d+kjUUYL1dId542vFJd10O0gIeNQ35khSm5WS4fO5n
 Bwfg==
X-Gm-Message-State: AOJu0YyA19SdSR+Dc7Ow6PvMXb/H3osPVMyV81ICpF2JmcEj6oIXj7OK
 rq6vvYmkRvP5Y6mzwpRQ4+g3FeXxS3OJj+EorRVMGwLc0yNn3mmG2Bor1aVvZJ2KMgbdoillhKz
 1W/wejv+5PyX4EjL4xDc4OLRZi2qBUdVf4VEht4K3MUmKPRuNz06HpHeib8vo/MGvjMsdbAWV8D
 6COhWJITOVkjfJzJ1gAoM=
X-Gm-Gg: AZuq6aL/Un4eLWcn+srGHu7WPbcVdby+E3NdYSixs1q2Srx8DMTtbf31tQIiRZ/auSM
 lLoaHDO64oz8lPMTFlseeXuK/thvRYRsw+AHbxKYOiN10nm7jOOMN0l+JfNYwK1RC5szYGjavTQ
 MXI9ItgijTtIkdsJWUowASfWxhP3x0JlEZpm3PbtGCwM6wx8FWYX1IKjqEikWSOrGpku6E8v4Dy
 jVGSDau9ZN9QFtGR5/Apti8KpxWXte4dUlhovG3Zju9C8N+oQ3YT2xceaKQ66tnqHMWQA==
X-Received: by 2002:a05:6512:398e:b0:59e:5bfa:4eaf with SMTP id
 2adb3069b0e04-59f69c6868amr2616572e87.37.1771253347200; 
 Mon, 16 Feb 2026 06:49:07 -0800 (PST)
X-Received: by 2002:a05:6512:398e:b0:59e:5bfa:4eaf with SMTP id
 2adb3069b0e04-59f69c6868amr2616565e87.37.1771253346736; Mon, 16 Feb 2026
 06:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
 <20260213152227.879170-1-bruce.richardson@intel.com>
In-Reply-To: <20260213152227.879170-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 16 Feb 2026 15:48:54 +0100
X-Gm-Features: AaiRm51OJs9RAPcLlj-MLRoVKBOUds3ORfDeU4RT-ZPE8tsFPjin1Upa7kOYfGg
Message-ID: <CAJFAV8y5PCivWu_a9EnbQ-5AJxe=1zcn2RBXHj8Zts3cTpZEOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] improve error reporting & resilience in unit tests
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gqymhonMTJevetwlqPjX7a73aYb0XwHtHO_kzF1h3dE_1771253347
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

On Fri, 13 Feb 2026 at 16:22, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> In the EAL flags unit tests sporadic errors were encountered which were proving
> both difficult to debug and to reproduce. This series aims to improve the
> situation by firstly adding more debug logs and output so we can better
> root cause any issues experienced. The final patch then removes pci probing from
> many test runs where its not needed, so as to avoid issues with unexpected
> drivers being loaded or probed due to the HW on the system running the tests.
>
> V2: split second patch into two, to separate out logging and no-pci changes
>
> Bruce Richardson (3):
>   eal: add location info to interrupt error message
>   test/eal_flags: add EAL debug flags to recursive calls
>   test/eal_flags: remove PCI probing for recursive calls
>
>  app/test/test_eal_flags.c              | 229 +++++++++++++------------
>  lib/eal/common/eal_common_interrupts.c |   2 +-
>  2 files changed, 123 insertions(+), 108 deletions(-)

Series applied, thanks.


-- 
David Marchand

