Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD88CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 07:49:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2381540272;
	Tue, 13 Oct 2026 09:49:37 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id B6523400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:49:35 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 2C98A1D000DA
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:49:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 03:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791877774;
 x=1791964174; bh=q7eKj9jmY2HZcCBvrYA/E9Srjz/mpTRvXjLlRjAzxLU=; b=
 oRCdxXc/F+vwOKfNii3H3IvbwjWGAhbJxz8BN/urOl70OILhXZtrHTyRNIouMCED
 /xZUsXoImiqIzV7hFmpI0m/JsyZ4WPjqjjkJXq5HKPoBJRkhHt8kenpf7UovpdSY
 yxp30D0Vwkh/JrtRoEmuINhdJnPW4TX7ljvza/79fO5rsCyhS+5w1mh1IXQERAz7
 81aveDwKbxwEZthE/c+NjPjGrfxxrxXi5Q1VfqJC9BEdDU6Whx01K0c/FeCYoud6
 5rPOnoS3yz8hdyG5DZ7I/3v9Y9SGy5XPJPgHJMOmR6ohHA63Mo+9FS4n6az2I4um
 8WKu4Q6LsnSOIuYnc4tzdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877774; x=
 1791964174; bh=q7eKj9jmY2HZcCBvrYA/E9Srjz/mpTRvXjLlRjAzxLU=; b=M
 lBU+lB7OOsAbpiVMbr/YzHnefiAREk4STLJygBb5eaGzPDBn5RvNCM57BTrDJRnk
 gzlVho1369Xd5cvdlMcmPXTAF1cw969ewZ4WfZ0vaVt3JAmTHBA9qOH4u8IHUXd5
 FAo74HDdhh+rSfuJjr40NfnqFy5vLs6HRjrT1SiNsw15UMBZFYaseGEvbtD/S7MF
 jPfkBlxg5PzP0DDrH7NHe/3csnYBDfHRP851cklkQZ/OOZs/KjbbkehyMNaaHJaN
 iW6nr/8+AC7LRcwFKOi6j2ppvlG3NQqnwbOoykKcx0F81v/Albt4/4TXXjDzE1jR
 sB5FjCM3V96KM5TtYug4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877774; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:O9glOlzojT1MTb05VD/Aqxh4+bwXoIF4jaN9tGcciMRvngO
 DktkRiQ6cNotOwDDzzuq1fBIRHIEOol67nk6ZqWdGHYd7Li5N6/XI70Cs0E9Ixl6
 JvgpWHShSVNNx5gXpyPrcwI7XD829oGcVQ16flS1F+ISirxEjBd1FRW6RZeujX9c
 RVhYYal6btEA3uEEuAzKQ7ApC9aFknxzwX76Y5GdzxtQX9twEZdMz8ebCIYsWm88
 +YaL5HurDzfbTU5wz2AILXOAtwBJ9V9wYT96wa2oiHHIJWrwSQNEcFTS1LGid3Q4
 8oaBCGSM+fiTh5rkau5T1WFwGqCVrz9Sm4CBkyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:dsRQrzb3zS1+a0ZJldqqf2FenVi6dkTKzrVQ9W1sP4Y=:J3JXT9VfB2V1VqgWgx6m8p4A8/gcAXxZdXQQSpTuHcw=;
X-ME-Sender: <xms:juLNap4Wf2ScITFpBrorruCWnjmHv1ybK8CkfRUQgbz2ZfaWpS1Qfw>
 <xme:juLNarOArnNVugW6PxbKERrkvaZwYP6C4r84fS4qHaVNtnQzE9Y57lXyNOCsxshBp
 zt6GlCeXB72XXeOZ3jqyM-KNoc3Z0lyOW84SOCEwI_zqPrNQcB5YXqm>
X-ME-Received: <xmr:juLNavlQhsNBubviqXD4sQdV-G_KwAjiDf-ypplEugdGCSpMS_Gjc_8qQKwPxeEwFhP-nSvmbOGwP3ad6Z0F5Tc>
X-ME-Proxy-Cause: dmFkZTGACQK1GeUa7bjMaEzpJyo+czXpjUXIwjEi3hoA5vodP8ihzN2fopzu1F/O5uoXQ7
 OFjiZXQLwsxlkmooaGPpZ2eNbKANaqglYHbAc40qRBHRbRD3zFTLw8mK8z8c+N8pH/AQhx
 0E63pb+OGuvyWE2SH9W44lCD/GeaGy+I1JU99p5Wn/oQjG5NfuN5AgwN+gG5U2czqvnT6Z
 NeA/vQm6svi8LPlGaSl6RlV9gMkGzp6/51Xxb2/zihtc5bbiZuSeDo7L42LnhZLeEvBMH6
 /pZwmQBgQKypJBneZp/YH+1OpYpRmaO7qJstwoVcesM1LDN2k9gcpUKhcPGLd6VKAKblWa
 ciaWQLJ3ObGK7qjXJ/858RCizvuXMCQle4i9b+P5eqKSS8aO/euEBIdlHjsVnIWJ6xzUdW
 JkGYjb/KADqJMpkSrRleBHOBCDeKAumgvd0aJNr8ZPM/0G5E903sWfhG0kt3qIicZsGVKY
 BYnqjhntg6XHlt6w+fQbyWSDLGY/DkUIhxqGxwNZmpuxpNNasWIkcNWr5Ue2Amer301QRi
 asWEYSrvuy3+KxeSo273FhNoJEb7DFd8bDB2C8yr+YfNl61XVndbUJnAFvv4GDhYAhHEim
 Jq6NOBxTgr3zPdrrotQDdWdR82TUmVC1NLMpdz67qMgBwMBCkwQ4dco2qMkA
X-ME-Proxy: <xmx:juLNaqQnTjKn897Q-YYXSv2gc2dcNV3bLImuJshB92dc7gM27ypd1w>
 <xmx:juLNajBBkprzx1ORJf3A2gZE0n1V41jy3YV-6PLXV7QiwyVxsztcVg>
 <xmx:juLNahRl4dc8wBsfbFOsOGmO82lTl2HMQPcP7z86iMZueaPp0LCBoQ>
 <xmx:juLNahp9mVxGqmcGzGwHVu-2zvRspvVBXTwsK5W4JRckj00N6kWsjQ>
 <xmx:juLNak2i-XKl0nlVwIEN37ljaxFK03S8idxVT0uenRnudm9_BhQyknIM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:49:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2] build: fix cross compilation to x86_64
Date: Tue, 13 Oct 2026 09:49:32 +0200
Message-ID: <gO2lw07QSVubxmsBdHTdeg@monjalon.net>
In-Reply-To: <20261007092637.916513-1-a.schollmeyer@syseleven.de>
References: <20261005125943.678879-1-a.schollmeyer@syseleven.de>
 <20261007092637.916513-1-a.schollmeyer@syseleven.de>
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

07/10/2026 11:26, Adrian Schollmeyer:
> If x86_64 is specified as target CPU instruction set (e.g. when
> cross-compiling *to* x86_64), the cpu_instruction_set may be set to
> x86_64, e.g. if it is derived from a Meson crossfile. However, while
> Meson uses "x86_64" as name for the x86_64 architecture, compiler
> options accept only "x86-64".
> 
> Introduce a conditional for handling this special case by changing
> cpu_instruction_set to the march-compatible value.
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> ---
> 
> v2 changes:
> 
>  * more explicit comment about GCC/Clang requiring x86-64
>  * switch to x86-64-v2 feature level
> 
>  config/meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)

Can this change be in config/x86/meson.build ?



