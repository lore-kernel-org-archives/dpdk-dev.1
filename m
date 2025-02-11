Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49F2C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 19:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBDFE409FA;
	Tue, 11 Feb 2025 20:45:24 +0100 (CET)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 by mails.dpdk.org (Postfix) with ESMTP id 92CCC4027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 20:45:23 +0100 (CET)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so4950268276.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739303123; x=1739907923; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CbCkXNBPtgeLs4fXrLfVnLtKaKh65r01nxD/bwrNR0I=;
 b=YOeot+2BLyBu1oXvQzDlpVtqsL7oMS9xuqfehmqXhP/crJHbYWTtf6Abxub6eSirEp
 RAj3BvQw1OGnjrfw1yM3iD08YUpe+21dUWuRHGbcaXidBY4WjZqOT9o5a2gn6Dm/z+ub
 Fmrk43MF4ePzOPFO4J3IXr0+TT9j8uGNYAfKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739303123; x=1739907923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbCkXNBPtgeLs4fXrLfVnLtKaKh65r01nxD/bwrNR0I=;
 b=gFtJcfsBZpl6TfcJ/+3WRzJPlZSbtk3V16GlvTLeisqs0G7bEcnshr9NG45FXB4b0r
 qMKG4vOSKUanwkSX58Jpt/rwRCf1YMTCinFzpK4NiSjP37C0S332r2B6J+EFCR4ulkgY
 bQpvCCb2P1ixaR/+gI9R6++vg4UjKFEnnJiJfTScq5D8ti5xhKuLKI1cz32YxsCFmRPw
 UtTi3IqjvSACQjI0EUd87skldhjpTaE699xMj5vkHz7BiRe2jNQ774N4jb0omBx6pnBk
 OWh7LQJ9mP72nlrifJJFn41QN3VI30VU8KlL342xaPzZfMLQhgL2uQgnp5irN8MVn9ho
 PdXQ==
X-Gm-Message-State: AOJu0YzHaohmXN76G+UyTNmvOR6ytVpXrQzBJL/2Om8/SBAmnrQUcLEO
 ITkgZZQwgQwoDiJ+KqEqKJFCUyDzq8VSLaajI1zD1FQ7m+SsFgAp2LSqO8ncAJ5lfsP6bSNrLB6
 /304VYtmb8+uA9fyQC9G+Rabvawc+yElyp8Ik8g==
X-Gm-Gg: ASbGncsrfAUgjB+mUpW+0H9cYe4PRomT/gTvshuHVvDT+x4TgNQzFrkD0V5YpQYssoK
 QRV47S9oiRkhaOB7yhxh+L1UVMs5Jy1mTgZI3z9fKEhz5eQijifHEEgc13DV+fKwfxzNAD4Awjm
 V3KIREUFoBxnzzc8DXAUQel9IywKtJCMY=
X-Google-Smtp-Source: AGHT+IFkaH1AY7tzrjJw/RDB0Hxlh03VW5yQpZ5rWfX4QEKCsak/plxJNLoQk5voI9NZCRjSVEeICU8CcCatMENHXUA=
X-Received: by 2002:a05:6902:f84:b0:e5b:33dc:f03f with SMTP id
 3f1490d57ef6-e5d9f11a95dmr752448276.23.1739303122864; Tue, 11 Feb 2025
 11:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-6-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-6-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 14:45:10 -0500
X-Gm-Features: AWEUYZn8vM67vKWZPXsfB8chBChhYZVAqDvfAILQQRfgFtr6JndsYjN4yEEK4no
Message-ID: <CABD7UXPKVCNYFueOcB_j7xYP2y0Z52MVhQOLQqdHTAJ9yT+9Tw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] dts: add runtime status
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
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

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Add a new module which defines the global runtime status of DTS and the
> distinct execution stages and steps.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>

Looks great!

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
