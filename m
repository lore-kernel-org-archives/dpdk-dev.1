Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC0CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 12:06:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE6E402DA;
	Thu, 15 Oct 2026 14:06:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8A256400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792065965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sf+F90jtCt9GH9fd1tTnURpqfScIPqO4SW99hLYaCns=;
 b=YfZ6XPwt2lMlD7VtZkz3wlH+6yXUgskXp6YtgPchWD+Nazh5IZ8fYSWnB8lvYP/YLJ7rd6
 QAGYRvaSp9nz7EW5c6fqce14w0r+H5HsZsBP7dFnZK/WTICsFlhLjwq3DV3gmb/mgLJkPt
 RQ1P8peExbZxyjYmyGOkSt6gaXGCmAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-ICEU-b9dN52umgSqfC0IoQ-1; Thu, 15 Oct 2026 12:06:04 +0000
X-MC-Unique: ICEU-b9dN52umgSqfC0IoQ-1
X-Mimecast-MFC-AGG-ID: ICEU-b9dN52umgSqfC0IoQ_1792065963
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a01ba12198so56905735e9.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 05:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792065963; x=1792670763;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sf+F90jtCt9GH9fd1tTnURpqfScIPqO4SW99hLYaCns=;
 b=V2kWRGnDhkSCO8jtKEzRioBBUjVSJLdJ4jCy2m9OaGd5NImXszoH3/siz8tbn5OaUp
 iya6olmzXTvV8abPebtctRGoSyNFnHGrypw7kONAlzvt0P1S1zCZ0VF9nwv8zFN0AR/1
 ZxDaTa38jAd/URdKUL557Vr1nzVrtudSezeLpa7I+P6KcDE0jP/PRR1Lsl4h9o0Pi9mp
 kATrf3c7nd3MkMzVfDuSZ1G0fUlDP2MSEmHCrYTFdPwOuFAhFMPyeLRA5y5BcJLrymaQ
 5hovz76+L564l000MiZSnEagPpcZn59XE26ebcRE+6dJZcBQqgFGQ4FvBCPQlGiBJOdr
 Pm8Q==
X-Gm-Message-State: AFq9FYLrCAeU9pdhZx3PGh/a4UgHpzForJg0VX3j95SFVGxcR1ghPZF2
 e3BMcPUH2aNxEm8Vn+0FXg0tt+O6NWrLt0ghC/jr0oq05exqUBGyXnaURkDe9xI7KeI/37rPxdG
 MP8klpIUz/0uG8SjHMg6VQaHDqGIWa5OW/Vret7MCOAS3/+xnxJUo
X-Gm-Gg: AYBFou0f1H0wP//yDsWqFbBP9nak2v5PJJbsxx3MvPAS6asI8qMvnf97+11Kpstic2S
 uN5MhLhfZrHI7P/Z8vJnXyw/PIQbwx3QjN3fyCYJx+F2XLLGLWEmJhHjbcKUg6/nH52rhR/nB+i
 VWlB3eS4G/J2YlOWaizAcUi65lrOl44/dyNsDFDjB78ZY3VyKuomrsgwBPi3wfTdJUF+ZuM9HSy
 aT2OcToJDtIqsTm9YYg/vrSGb7AGjYn9OU3CPtpZL7ow2Jl6A7MOwaiDEenu/p7PwTOhzuUOR3J
 mbubgYwVh6rdk/EEbuGPcAZJzUMMkuO+Ts3Ou7ftRFm001RsFcF3IVsdcnBmbIlDC4TBMqeORmI
 gXI5UacWN6k9tbT+QyqTD8BBdc0v/umrbDHMwPjExKzoFJduW4A5NJwRw
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a18e447d8bmr369604575e9.2.1792065962628; 
 Thu, 15 Oct 2026 05:06:02 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a18e447d8bmr369604085e9.2.1792065962073; 
 Thu, 15 Oct 2026 05:06:02 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd97ef4dsm73181455e9.4.2026.10.15.05.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 05:06:01 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 Oct 2026 14:06:00 +0200
Message-Id: <DM5ED553NJLC.NBQ71EIJ8HFP@redhat.com>
Subject: Re: [PATCH dpdk v2 2/2] meson: add drivers to dynamic libraries
Cc: <dev@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015112607.3008792-4-rjarry@redhat.com>
 <20261015112607.3008792-6-rjarry@redhat.com>
 <atC-kJHTeupb1Qri@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atC-kJHTeupb1Qri@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: szM0n3Tf3VKO0RLgJlkoJ5BILt7monPl3DcYmpRBASI_1792065963
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Bruce Richardson, Oct 15, 2026 at 13:52:
> I think this changes significantly how out pkg-config files are working, =
vs
> our original intention, so I think it actually needs more discussion.
>
> As originally designed, when dynamically linking against DPDK the pkg-con=
fig
> --libs libdpdk call was only meant to list out the libraries, with driver=
s
> being dynamically loaded at runtime. Since drivers were never meant to ha=
ve
> a public API that was generally used, I believe the idea was that anyone
> using driver-specific APIs was required themselves to pass the driver
> explicitly to the linker. Otherwise everyone who does not use that driver
> could end up (depending on their linker flags) with a dependency on that
> unused driver. This change modifies that assumption and, while it makes i=
t
> easier for those using driver-specific APIs, it does change how things ha=
ve
> worked up till now.
>
> On my system using a default build, this adds 33 drivers to the list of
> libraries to link against when using pkg-config --libs.

But since these libraries are preceded by -Wl,--as-needed, only ones
that expose symbols that your binary uses will be linked. I don't think
it would change anything in the final result.

Also, this aligns with what the static build is doing: list all drivers
as well albeit with -Wl,--whole-archive and *without* -Wl,--as-needed.

What do you think?

--=20
Robin

# Do not try this at home.

