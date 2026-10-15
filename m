Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166E6CC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:30:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 549C1402DF;
	Thu, 15 Oct 2026 19:30:07 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 0B1C54027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:30:06 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 69EAD1D000FA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:30:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 13:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792085405;
 x=1792171805; bh=LEpo6fbDvlfvG3Py68gIzc4mduoXdEoqDgHZ/xlv5Tg=; b=
 Yu+XKhtZL6aZFQ+FTQnYEpbhgM5vPQZKNK0urMVioxMgDrjHr1IcLMoxDUKN6uHQ
 koRjyFdHS8TQwjJzagQdxbRNQDxny3HpfwMVcQRuZCkMMLf9CAD0voj2ZqwFmkzg
 jKiUYAmUsPzIHAc/8zT/26buHQMG59vPPQk+kEmsNk8iCB7R5kqWBxTl7X2UAujS
 YggR5KdShXLdobitHKblGonhy0GOacpTVB+F/z5V240NBqlG6xLdVIu67FeFduva
 jmI65mVIjTIfLoCF9VT+xk50+yDOnqzWnYFl70P81RLnDSKYkLHlpxllalvXuKs4
 ggcMEKemUA4SdhKkOFiF+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792085405; x=
 1792171805; bh=LEpo6fbDvlfvG3Py68gIzc4mduoXdEoqDgHZ/xlv5Tg=; b=x
 fZbh0zURWEYbqfJywX62C9/L64olYU3oUymBftXpdxRzsNrKKUPq2rr9mvqbNf3S
 seVm/9vmVuVonYLlVuBPY7Uai4NyNZMOat2B9jU7b9f3m5WUynnk3A5zNIbsIKoX
 dsqxzDlB+PcjTip5CvxKK1PdRn8zj7riEzJ6H2QbRqS2qBZXLrNQGYWuSmQL8iNk
 CU93EPsig417HUB2e0dfa2suATBnhx/+K7M61cLWXAxpDxripxHjNVTt4C1DzhYC
 byAUAPbf7KG+GAg5kVO+0ToCdfQWNEt3X742ossxklS9wQpBckP933DH+pUQP5RY
 CKFBfzFOVINixi0LehX0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792085405; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:U9mD8qL68l3Usp+bdk+IraPHSUYzV+3xHeKnfq/yNMr56m8
 8Xsh/T8b8EGmstQkbIvj6uyYVzCsFaQVuRNrnaAi8IsNfyxLRGa3pHYmO53PzmfV
 4x761rxKI4xahjGRQMOJKKHblPs9ypVuzuzqjWiDeGnESv3wF2czXV4xBL0craa8
 TO8Q/GdNOMxLyqIA5yqPFv5i1y3TfjvroNpQavJU1+NyWnisTJFvoR+CLrVNd+lU
 lbtGzmdCySu7WIxv3HO/Fj3Mu6ubYdzg41Hyx3Un+kTK+jagvdvXksl35IpFGKa4
 +KUXCsp+D0CTUDyKyMsfObqlTvGKmsA8XjxyB0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:tl0oJjkUoQL/RcR4FSDw5GbsNW1Fxgnuexub4pGONE0=:DQxEu7e+ma7LLCJVRuUMh3sSbsix26gSq0CVgLciIu8=;
X-ME-Sender: <xms:nA3RatcyXeIntaB_On5KpKSbeVJpIc1RKVz_zZDTvOp_Xo35JZMfqQ>
 <xme:nA3Ravi6JwupSrBrCjV3Ei3Y7dXfz848J9TIF0cP4mLhHL7EGSqmelSPjZKQcnWzw
 hM5L6dbYwwqfeVRFqRBXdPgKLEPqL8_CzA7NQBXJHU6b6aBF92v5w>
X-ME-Received: <xmr:nA3RaloeGrp0WqvA9jVX57x8ykIgl4NuqrqYCK-N8IPmIgHoAJYkJZxBTFbmBqMG82V9lS6msdfT6K_ktth05tg>
X-ME-Proxy-Cause: dmFkZTE6U+KmjtgD87X3crFCVMazmcbal8kGUDFoUaOnnaaR+q4Axs2RynqBANnZgLNVz7
 dcBuHRe+/6dH+JAPY3IhLskF1O5Z71peWUlAzErogF1Y6B0hEYzCflFeztsKc9ds5kW9g3
 GUAQ67e9Ews19xXSaJnUkC0qR/ybGxJSIPza1uvQ29SSB56Cb4eHDzJNTnF+yhFN+8Muvr
 +aZBmPTyvhBY3zO/k58YFPCBXArHCo+JwFeH4JV/XwKr0Tknj6+rDVip5aCimvhCpYl5Lk
 dqVN7JAaZ30PMfVtk0tlCq8OQHY3R+1/jv7xBdcmx4E2OwPGjQMNt7SOS7Ej7EZ35nyyRJ
 0PK3ehmpSkXkV3DPw49W87IeLiOb6jY9WjDEBCc30Nak1ZxnXxrUqb6BLkhl6faRi1+9mc
 gIrgpfJoSU+IhYXNT1Hqx26pQDuPsAb0tKvrYYPAjAgt3V0zFKM+47X21kq1yQsTroCy7h
 kBjAh1P9ogNWq5j/uuwoBC8dRB9eOsMZtYYseL9wipuYv3cSA5y1HBNDwJJxO8C+ZJWDmW
 AL94nD3aCGln49KnZNJJ1B/v8YcuYeyz3m0ttRb4qapomgYshbx2IUQBcaIuJUnBNFsYzy
 xeXcfCQ2SUz+JS98ckSdn154miurniK46cKYiiuJBKeDImC0qlcVGqG/EkPg
X-ME-Proxy: <xmx:nA3RavG_LW3vyVCZiubo93NQ4sdjvxlfegOg4RhwnAuZia5NW9KEyA>
 <xmx:nA3RavlHl7u4__dOunJqihaEhh-cXfYuW5CffJawpPIE66kR5B46lQ>
 <xmx:nA3RaqneafrPzIJ_pCqwm5C4CdnLtloG-tIyg-8IEGSHtlhAXmgCkg>
 <xmx:nA3RaosfTfk7gXNUwofLkJqTY-pbBwI-BYZruKzL7u9tZqyf3dptdQ>
 <xmx:nQ3Ralqy7icjxthNg0TBXG8uiLopKZm97rk0HXej38ROKxxQN9VoFMwn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:30:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] build: fix cross compilation to x86_64
Date: Thu, 15 Oct 2026 19:29:59 +0200
Message-ID: <EgWUEoASTzKcqAyy5fqE5A@monjalon.net>
In-Reply-To: <asYhZ4qBtarVLKng@bricha3-mobl1.ger.corp.intel.com>
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
 <20261007092637.916513-1-a.schollmeyer@syseleven.de>
 <asYhZ4qBtarVLKng@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

07/10/2026 12:39, Bruce Richardson:
> On Wed, Oct 07, 2026 at 11:26:29AM +0200, Adrian Schollmeyer wrote:
> > If x86_64 is specified as target CPU instruction set (e.g. when
> > cross-compiling *to* x86_64), the cpu_instruction_set may be set to
> > x86_64, e.g. if it is derived from a Meson crossfile. However, while
> > Meson uses "x86_64" as name for the x86_64 architecture, compiler
> > options accept only "x86-64".
> > 
> > Introduce a conditional for handling this special case by changing
> > cpu_instruction_set to the march-compatible value.
> > 
> > Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.

It would be nice to move all arch-specific settings
in their subdirectory config/$arch/.



