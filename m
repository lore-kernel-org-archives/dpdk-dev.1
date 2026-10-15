Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E187CC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 23:33:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01F04400EF;
	Fri, 16 Oct 2026 01:33:23 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id D8DB140041
 for <dev@dpdk.org>; Fri, 16 Oct 2026 01:33:21 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 21EAD1D00109
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:33:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 15 Oct 2026 19:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792107200;
 x=1792193600; bh=hf5aMxe7qOEQyKhIzHe1V2akNdYNL9P+tdVmjT441QQ=; b=
 oYd9slCyM7wUdTX0EBeqj0JVSTOJKoap6Hy8SgVStsk8mraciXNqgYE2v5AOGtJE
 5WI7ec40q+Qp4lYuaKDhUhGWAa7fK/sRBhHI2he/EjAf6em0hHqx5ragKaV53Oug
 8wJ3oXknZNAzSkSUU2ThlO80mfF5WTWT7CjKrk2LifYKrvOMrZ2q8NPIHaafNy1M
 hLHzVOvcH8chmdOttsF9shSklZAZmn4yc0pmQPvDuViTjQez2u6Nz6D5sepDMWps
 DUXssjziJNWWXnMyn5YwyO1QVuVc3qktRVU5JlBMlGmx8DxBB70we5NcyIathptg
 QkD4i0HCxq1HKvJoA+yuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792107200; x=
 1792193600; bh=hf5aMxe7qOEQyKhIzHe1V2akNdYNL9P+tdVmjT441QQ=; b=O
 hF9bwaH4TMCH/MxC4WFS2NVx6tkCDQr97lYGxN5FexTymQ2eLdw/3JcBC2Dl9L7f
 QV+ph6Urv+m7ca8iVdAKrXUPOM6XZiCVdJwiAqEcBT2mOV0m+Xc+Kxq1kqTS1glG
 tX01ulrHmTNmzLCSO0z2wu8NeSI43+PkiXZvHxF6bXAK4kA6SWI6J2TS0afINBIx
 qQQwYpTpNzDlUac1Bq3rw3s1Yt+yjHjCZ3UNXap4fxNpGz//zbr8vuiyaVv+oBI/
 fSWdvGXz8eIKV7ibinWuNrC7SctGeQvyaZjhrNqQ2plb+T35Yn155DeSDK0CkVNX
 l9enYRDKJ2wmXSt739E8A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792107200; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:jlEoTVfy68FxfNqBeekM0KBFuTFkx2FkmLRc9nYGL7dchmK
 rkKoaLtMbSd+VS/If39gowlEE8PHOa8XC1Opx5hINy8N/ZFwtAW69kEk6xKXGkr7
 fDdmaggV1X/rxPuKqDBZhMB/3h9DAt+xVQzFEHuEaxk5dTpGrO5/DzqRgjkvsgGZ
 GinXRMIXgOYQyO5qIJ3OsL43Tif8rYZkUhseHYexNZDMZXpsJJaH6RuP09K7x2X5
 d8mB39cT/Z7thhcREWbMBLMcO85sDVRFH/Q15UZm72ialWBlGwPWp+eA2FdCtN+b
 n3hXUhBQZkDtfGMM6tf8cMiZ0na48mLhueOfNKg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:uVWxIT/q6/Huuy2HoI+CxXh2B4eNjp9RxKAaatf+yh4=:hf5aMxe7qOEQyKhIzHe1V2akNdYNL9P+tdVmjT441QQ=;
X-ME-Sender: <xms:wGLRauGSSoZWg0uV0AVrLMgfvFzAHPoFDRkcfdZrSzzMayoRx7uVdw>
 <xme:wGLRaqz9uAH6kjAFhPrGRhoQjMSSB4uRRdL0JL_lv9Zvg115aVztZnnO69HwVRXQq
 vKCjhI7g7eQdSX_79M7YLn25VB_Rb3CwOU12VzooL_6O6RYPdlUeA4>
X-ME-Received: <xmr:wGLRarqdJ3oTxvxFmaXujcxZKhIQo7Bzz_X1MZiMPwWCTvv6dkT2OozV0HULnvVxWBTQCjCqyAyYl-rExZ_BVSY>
X-ME-Proxy-Cause: dmFkZTEFhk0qkWu7dUNYv8+xJKz7LmuPm9CqtDBB4aRQJ1B+AkEwAPodMhYo4cALJHB/st
 80THP/0M+s0EqgfrGya5lxV2c229DKzyliWw1LPMaDcGAhCD+cFS0XPxrhMwOejBSv2N4P
 JRJXtBjY6KZRQ/dtvsJXySxEfw+Ig2H2c4/YAqB2rDdumZn5Yq+2mGS9+2iO78NLAh7mjX
 ZvPaHuRZpDa88tKl61egK8ZKKdUH23sAb8RHXdHkKVgtNBKBhFygBMcVTMAeNueHzEnrDp
 wprp4gnFAuwyvuoctoGSFwQe7WCuZ9nk7wzxrikFRAvPGxnS8DqBuGorXq83NLG+1enQkB
 dTs++IcJFpTExvlGVeUilA86ORbYqxggobZgkrK8EiVDqNsz5ks7UuuPJs5eGrL/B0jZtr
 c/+EXvev/W2O5qJ2Y0wFJ1U1JfV2RjSLR9royhMV80T8BVYWUiCIjt1HkXMr9BpabocK9L
 TY5evkfWPwCsWF8RYRFtXrcueg82CXJ8tm7ggMks36kIgJoXLJ1NgJpHQiNDxJz3vykxvN
 XCtRoVWoDp1sTuIO3e6ZqRPLAsdbzuOmThiCpib08SMPl8cE+PPX1TK7hF+4F6rIt9PYTb
 QdN0wIMZGiOCEUfyge1rKdDm4csAq6GZOJyVXM3i6kvpfybvw0NCLFlqVCVA
X-ME-Proxy: <xmx:wGLRasgqOGnNBmHvSL-Y0vXUQIuT8l7vq_E1BC5me16Z9xARkxTthg>
 <xmx:wGLRagh6zMZ_Akpi9E8VTCA30txhsrOCYhOu3D8Zi8Oev7r1cAPhYQ>
 <xmx:wGLRaqhPtE-mfCTQ-qtUB9tYZosMOb-uFiP3CTBUu7gYk_fbaW5TqA>
 <xmx:wGLRaoKXTEMBQUhayVgsVatrJUnk2XO07tADrrOEr1y4FwuDDC9BlA>
 <xmx:wGLRaih8xvmEFeJm45ZHWFbsusd8his8iYdMPt0yvNrn-DedliE2tG7H>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 19:33:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <qm2k21@gmail.com>, Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4 7/7] app/validate-bpf: add BPF validation application
Date: Fri, 16 Oct 2026 01:33:16 +0200
Message-ID: <T5P7ebNzTTqVuRXvg1A0FQ@monjalon.net>
In-Reply-To: <20260917143539.46951-8-qm2k21@gmail.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
 <20260917143539.46951-8-qm2k21@gmail.com>
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

17/09/2026 16:35, Marat Khalili:
> Add a new DPDK application, dpdk-validate-bpf, for pre-validating eBPF
> programs for compatibility with the lib/bpf execution context.

Now that registers are private to the library,
this application cannot compile.


