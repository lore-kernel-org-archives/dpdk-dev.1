Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE26E7544B
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 13:07:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 277ED40262;
	Wed, 24 Dec 2025 14:07:00 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 884C74025A
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:06:58 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-88a2f2e5445so71901746d6.1
 for <dev@dpdk.org>; Wed, 24 Dec 2025 05:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766581618; x=1767186418; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doXtrLdI0AJGqVkm6K8i2yZ6dHUbHGe9p7LMZM8u91s=;
 b=nRjeZ4IrgsPk086LErj18J5QRiPK6SyDI4+a/tmYul4QT7QP0DX0jCI9W1ybS1iuxn
 k1bvK0jax9Kl6DuH12KZIV3MfTZ3Ru6EWGbjPPwxtz6r3A/DY0PEhES9Nkii7o2F9sYe
 1LC84jSpiq/2oI/YwtREaWfUQY9v72ofAiaIq5MHlfYhxX4ASDlqTI8g3e36jnBgZ5JA
 boVFfUJOJPfjIC+DadBo9mUDmBn2p2FY+ebmxrDVDW4b3k7diVw5WkUiOxdVfWaQ32wn
 q9PtlPH8sEj2dMezWs/f43udF8WzGz5TKKwOLBzukLToneYkFaamTGQJNL0QSonkCxFF
 Pk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766581618; x=1767186418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=doXtrLdI0AJGqVkm6K8i2yZ6dHUbHGe9p7LMZM8u91s=;
 b=J7sFgzE6ErsmJVpumsSWGOa6NrPf/93rIA5Q6iNZvbJPHxEI3bEXEJGIcCmLr44+a/
 col99WYhd1fnm3MGzEXc2jMS+KIXHPecbnb6nu06AP+913G0vztX+poqhAVEOkOlTN4f
 Auw+eZU6cFebTn0+FcudkNwqdFtfzqAuMYt2i4Bt/mM+qsSRkHAaZSEYb1l2WzPDM9Ic
 Htv/1qlX9hOaaLPZxj+VaGYGf9sh7i8GhEGl5p2pU+4opOytv0d1KEZExkfz6KIKY+kI
 HkM1HG8DjapC/bMn6A9rNjuA6LWow6SnBQaoqLhoopl0vfl414h0WrWgtcUBpk4Uujoq
 an0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH3Xlw5vakudw6ij22rqa3rDAaO2HPyE/yfhRe4UyNunNkVPqVwzIq9cfRKyBBmsLJu1A=@dpdk.org
X-Gm-Message-State: AOJu0YzkIrfv09H7ZsvaJXAChEm4vsLgQzCFUP32KSdc6fsmW0qyf7MV
 9JgEzRKY4AR9ctZyZLstidzYyTTdNc8XqaIbsbRVX5j5/YC83ibpt+DCh6OuyCXf3zOhBbWapSt
 XPbwtc15pmIiyy+tW+YNIH/L/56GYKgE=
X-Gm-Gg: AY/fxX7y5GdysSicC2gk86SedULM4ROvlM02aRbndQ504S+snC2ygifdnmQnnS/huFf
 rNgYw4iwSDpqMX0KsocktmpEGoryhG5cmdSYUu0aUB5OK30AkMR59eYXa2UmT1rSXL91Y0rw3UV
 6vJOTsnV1Wgq2PlNaUJbupbD7ltoAfYBb/Vq8uhcT5ICg3NvMzzMM8FnB+YuCzVychKBp5gu37m
 9rZQ69W/8SoE23KFi0xTV2Y98q0ijUPUBwmFjk8J9FaBiKNqFLDXGBR3JQjykm3ukjWngccmPOx
 eg1SBC4p+ZbWxfd3UKxNR4y0uNGsSBALIrhBjH91
X-Google-Smtp-Source: AGHT+IHI67PFYEFl2DNMbPcjyUj89yWVXQUNbjRDqIUOTO8g+BQPtmbwv8NVY3jr87R7AwPDRT4yy3fc9aP5n5dehQw=
X-Received: by 2002:a05:6214:ab0:b0:88a:529a:a543 with SMTP id
 6a1803df08f44-88d84c1b22cmr195684946d6.69.1766581617801; Wed, 24 Dec 2025
 05:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
 <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
 <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
 <IA1PR12MB662825D68B439AA92B0D249EB3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
 <IA1PR12MB8077E548000554C0B770779EB2B2A@IA1PR12MB8077.namprd12.prod.outlook.com>
 <IA1PR12MB6628D5EE5A1CBDF44D9F1408B3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB6628D5EE5A1CBDF44D9F1408B3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 24 Dec 2025 13:06:46 +0000
X-Gm-Features: AQt7F2rw5N8JTnZyWn5EimR967tGDthxxL7hceC81BwtCb1zyS4wdHNekdqt-TE
Message-ID: <CAMw=ZnRHg=0sKmZa72amrSgALsn7LoTS0U_o1UXKwk1s0c9Mig@mail.gmail.com>
Subject: Re: 22.11.11 patches review and test
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>
Cc: Maayan Kashani <mkashani@nvidia.com>, Ali Alnubani <alialnu@nvidia.com>, 
 Shani Peretz <shperetz@nvidia.com>, Kevin Traynor <ktraynor@redhat.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>,
 John McNamara <john.mcnamara@intel.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 Salaheddin Badawi <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>
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

On Wed, 24 Dec 2025 at 10:12, Minggang(Gavin) Li <gavinl@nvidia.com> wrote:
>
> Sorry @Luca Boccassi, @Shani Peretz and @Kevin Traynor,
> I double checked the first commit of the three and found that I did tag i=
t with CC stable but missed the following commits to fix a bug introduce by=
 it. This is the root cause of the mess made by me. The first commit introd=
uced behavior change that should not be backported to stable branches.
> Please revert the commits mentioned.

Ok no problem, thanks for checking, I'll revert and proceed with the releas=
e
