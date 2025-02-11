Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F96FC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 13:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FAF340156;
	Tue, 11 Feb 2025 14:01:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A02C840150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739278913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RB0R3ykheA9WVq++a7Ug2hC+uozs+Yu0kA/p5C40l+I=;
 b=a8lK2tKCtbOjVswaRT8xIf1IeTfJTRj2/DiOrdi4X6CW3L2U37VWQvhZHJUlsA5sYAVCTY
 PHzO5csSA5V3UZyJgrFmb1UcayGcQ/8rQwuGXZNZMavBD3jPtPWqFcY8V9tR1QJqwP1Oy/
 7U9Nmk44IHAIf1R7AuUI7m3G94Z7gZc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-jASTyqfrOpm0wMpx5EqkdQ-1; Tue, 11 Feb 2025 08:01:51 -0500
X-MC-Unique: jASTyqfrOpm0wMpx5EqkdQ-1
X-Mimecast-MFC-AGG-ID: jASTyqfrOpm0wMpx5EqkdQ
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-542b0b12995so3272438e87.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 05:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739278910; x=1739883710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RB0R3ykheA9WVq++a7Ug2hC+uozs+Yu0kA/p5C40l+I=;
 b=UAGVypgTQki0BPwA2A2VFVuK8j3dWiLeP9rqfDLcMRk+Ll39cju62qFJzuulwty+9D
 mp4l8DK+mCJw7JZrf63o7Prpz2TxgxcsLiWxeIR7Bwq7iQp8FgUFrGcx1SSyVYRyekJU
 AIi8uDNbcspPES72tHEk5PwpWrdtu404arO0fwg26er0wgCU1fk1yOqZidrXBs0EZmYg
 2vTrfvXiTisdTY9eqm/0yGaKD9yXWQkLU8sHiKkPCG2vHhkKL5b/LzsB3l3LSZ71K9Pw
 KcGXBONfnXXHlRSxN6uP5hHBc97PNhFMHS1qv+WFhTjmAggij6KcDeJUlSvBvp0JLRMP
 ojrg==
X-Gm-Message-State: AOJu0Yy/eAT/iDN67+X7eYqrFzBTfH+WbDVW+O8vUPxLpQ+0bqC/0SWF
 y4TswDzUbLwc1V/9XVytba8VNWqUqtsEhwegmHWYcFZ3wzN1cZ7RByuX5Rr6iryCexX5x8/ypWx
 aw5kCKVcRnavRx1kPvab1Uod3aiX7ExNKsfPhyl+rYEt+sJTfY90UORgDbM2Ky/jR0X0nueQSzM
 N/0whMOFovYWXH1P8=
X-Gm-Gg: ASbGncuTI1UbN/0Ra+OQOcgl2VpFESFIvfaDgej+wTiYIh02ywoozHp0FYerIhlza6n
 iyes8a7crZcyQAnm6oj58TQi5a02Hxt2aMMNmVxtYTHx++xRT7e/9Ec23cbsJrurg
X-Received: by 2002:ac2:4e04:0:b0:545:c33:40a7 with SMTP id
 2adb3069b0e04-5450c334de3mr2505967e87.26.1739278909980; 
 Tue, 11 Feb 2025 05:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS57iuvlApO4ohg2fVgu06TFA9s0ulkyqIwMLXPRYMl8TCdOdZbeCd0/SSKRa+HSSl3thIL98eYqYIV8h+Sc8=
X-Received: by 2002:ac2:4e04:0:b0:545:c33:40a7 with SMTP id
 2adb3069b0e04-5450c334de3mr2505932e87.26.1739278909348; Tue, 11 Feb 2025
 05:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 14:01:37 +0100
X-Gm-Features: AWEUYZlBLY_z1erTL14oousr_iiMs6Gz11YwPH0EuoyKdlU116izaa9RmErahZw
Message-ID: <CAJFAV8xK_nAriEig9Dq98KMLfHrwT1s=p4KychVGGYywp+q0QQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Defer lcore variables allocation
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, frode.nordahl@canonical.com, 
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xf5TUq_AwHGf8x2eBVW8RFwdHu7axC4DB5pZlBN0SXM_1739278910
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

On Mon, Feb 10, 2025 at 10:32=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> As I had reported in 24.11-rc2, the lcore variables allocation have a
> noticeable impact on applications consuming DPDK, even when such
> applications does not use DPDK, or use features associated to
> some lcore variables.
>
> While the amount has been reduced in a rush before rc2,
> there are still cases when the increased memory footprint is noticed
> like in scaling tests.
> See https://bugs.launchpad.net/ubuntu/+source/dpdk/+bug/2090931
>
>
> lcore variable allocations in constructor is a bad idea, as the
> application consuming DPDK has no control over such allocation:
> linking some code does not mean that all of it will be used at runtime.
>
> The general question on whether lcore variables in constructor should
> be forbidden, is left to a later discussion.
>
> For now, this series only focus on fixing subsystems using lcore
> variables so that those allocations are deferred either in rte_eal_init()
> or in the path that does require such lcore variables.
>
> Changes since v2:
> - added assert in rte_s?rand(),

Series applied, thanks.


--=20
David Marchand

