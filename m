Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C3606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=NYyKDiX2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sb4ka8Q/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A807040A79;
	Wed,  4 Nov 2026 17:07:06 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTPS id 5A2FC40299
 for <dev@dpdk.org>; Wed,  4 Nov 2026 17:07:05 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 461E11400191
 for <dev@dpdk.org>; Wed,  4 Nov 2026 11:07:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 04 Nov 2026 11:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1793808424;
 x=1793894824; bh=xr2TvRy1Zq55+iK0CCdJdDmDuk9/FH4/a/dORMdKGMI=; b=
 NYyKDiX2e0TPdb7qadoV7y/7x++H8QJT2BFoFAQEN96UR6Zfhy1Ic9w0BS+1tc4X
 S+5f++vlgN7aP5S5yBRvtrwyujKhsTXOmNA0CH1pqcPbFI6GMou3hVrq2qZMlnnz
 eYp4JU3iF3JsJJ7kGl1hE9/n0vpYKBmkto1Yrh3gpaS8TTlrR5cYpHxp5vxnwXBg
 fYVSxlTaSGpgrMr9h11CGU1bp+u2YzlLqLhdQditoLuJVK2vuHPWgnmRCBHTXM30
 QMWuwgbLfNmwuCzdNfFYalvSucdxFJt/+k0nyqnBvQA4tqEuFULAQsWqzR24GlhV
 txbYh5VllJDFeauDQUXj+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793808424; x=
 1793894824; bh=xr2TvRy1Zq55+iK0CCdJdDmDuk9/FH4/a/dORMdKGMI=; b=s
 b4ka8Q/AMCSdjmx+C9t22qH59c0c/U0OcvLosLjH2y1jjjRoZusAXKdjlmzTq2TH
 slYUHSKinwxbWBFfxRn53I3ONuo42sjwrpiJukuh6bhxoqm1aVrSFaHLHBSM1S1P
 Xgn4MUFOUdU66XLEg+3L5XnrR26V8Ca92iRLEkFvTgRrGjjpiFrFSumRH/I92VV2
 4/Hl4ngX6CgFda6j+hmCLNEQlay+6f5sPyWqulInGIxhnTKqfeLfafEmVSvuWvmy
 /jgBM3An/lgrKfyJBJbQNYn2LZa4amuqzEK4c7dUVWvVbSU9cbz8VR3jqeP5/sVn
 BmgVXYnCxQZBImeTdkdLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793808424; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:yMCSJosMFpCMtznfP9d+nhpC8n2FgmV/w/QLmd3LIy0A1an
 Sne56w4FhL9LVAobKWqjudYIZv0TnaigRFO+o+cHLseX/b8DlydRrRumwF+MKB+y
 p6Lwo4tBbKmngOggbyMfv60obOf23eWAyJqcZyJBzcMyueMnK5F+ZvgVJHhJDRhP
 NOv/ek7F/dkqnJmfS7LoQooCiUleGSv1RsTmzkPhWiRnMZtx5BYIVzbcoYKYPntL
 YC5N8zuYWgMLapTlCJ4ugqDA9ekqVfOHqgIAuhzUrLo/Q0uzv+NCIccpFKy9uHJL
 /SQ9gc8nKC2OkehkDP+sNb/8PYDlscSrqQ3doDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:r1zhAoViIhmmXKLn6JgsT2duqeLi4OrypknhFvi8Epw=:3djkAxSEOq5xJyzXdf6uWphcqw2jgyM3WFIn5Ygfa6o=;
X-ME-Sender: <xms:J1jrarBqvvmqjkbFWwpK69JXhQywqDX_4pf6NwDjSLc-zpsHRwDvqw>
 <xme:J1jraqfmKWi9gZft0aR5Y1hatHBI0zSDdvGLhs7g3t28vsxnO6q8LCHJagiojrPCh
 XZCPg1lpe8XynmCjwBqdlqQj7FM3Va0mk_ASs-ZHsBZIGjsp-2qNA>
X-ME-Received: <xmr:J1jraiKHPskZs58kdpuTuQ_R86SlDfNHlZlMT1cf3udag7Am0I7kFz1EYR8IeyykGLqNLuP-5gqLp1Dqk20AM9w>
X-ME-Proxy-Cause: dmFkZTGcDaCfaJAhqBrEdOzXkt6Q/xm2FgzECBHvRleVs2mUnSG53qySNXPmGmTt//r3tQ
 nQbpLTvzSlRuPj9uaweyWIvz3yuA1EcH0KbVuAQ8qKq5Ewh8KJndXPzu++6YUnhqQWhiz7
 MBuUNyXxA64AIBIJ85mDvHt9ucYMXQ9F6dX7/4a39OPepKkSbqQVWk/oT1JqYxZS2tSlTu
 +eHcYHqNPObOtWShqW5w/72tCWyCdnwYgppbeT8VezB1uNKL6J94knu8qXiI97dILqkWuK
 8sCRiKbhmIFRCGzmrFh1CjfgiOw/8HAVTJgXgjVvaW/d5o0RUBtLHv0LATRpzjTepL+ALC
 tBRhNLGP0driIam6D6su4pr/nV4Foq3dSJlFDsOVMXB7/XY1tYx093S7dhpX0wtbAp3BdL
 8USojLuVCeiNRtWFyXSCixa4Kr+vs8OfBZSsm14k0Fq7Ft/lFQLa3wZbPSMT+YDA+WYn0L
 peWB6rZhVBjuZNFfXqsCVqgSdjH3f7HxWSkc96VzcR9z0v6DFwg3ArB5TZ5P6/pU9gtt08
 ZJhjYCSi1GOtd6juFZT1DaJ4WUpJQFagP7KH5BKfqnWvq09QT2A2wU+YYVMf1LWgkkBThq
 Vlm3+uGS96wiTSgDPp5D2qdPXGZ8VBa9v2MPfX0vphWo70VoesdIjQ7PSXnQ
X-ME-Proxy: <xmx:J1jrat1W0ePvL0EmuqusKYRKs322pEpgpsVadJkse9u0YUFuKwIbew>
 <xmx:J1jrasjkqxbXgCF9b4yGtKG9jtAnuv87RC8oRhxcm1tLoToWiI2tuA>
 <xmx:J1jrauWICVMzE2wDb9a3MLpQS2EsSJx_Y_WIT3DhSHruRiJKgJeqQg>
 <xmx:J1jrarXWnhsR-zDODBV0oZM2l6MgsQn3s6LeSlpWXlUjKC0IjhICqQ>
 <xmx:KFjrakVQ-9r1YtzS0LAon43_AQnjUMH-f4nBbrRNKvA2OEZ3EWR_9BLX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 11:07:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: dev@dpdk.org, Jakub Grajciar <jgrajcia@cisco.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] net/memif: fix race between interrupt thread and stop
Date: Wed, 04 Nov 2026 17:07:00 +0100
Message-ID: <eY-Q6aGOSBGpqOvPieWp8g@monjalon.net>
In-Reply-To: <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
References: <20261029100329.3cb8fa14@phoenix.local>
 <20261030102218.3489371-1-sriram.yagnaraman@ericsson.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

30/10/2026 11:22, Sriram Yagnaraman:
> The control-channel callback runs on the interrupt thread and calls
> memif_disconnect() when the peer hangs up. Nothing ordered this against
> an application thread stopping and closing the same port. When the peer
> of a loopback pair is stopped first, the callback can still be running
> memif_disconnect() while the port is closed and released, and then
> dereferences dev->data which is NULL. Seen as a SIGSEGV on the interrupt
> thread during memif_pmd_autotest teardown.
> 
> Detach the control channel in memif_cc_detach(), called without cc_lock:
> 
>   - take pmd->cc under cc_lock so only one caller owns it;
>   - on the interrupt thread (the callback itself) defer the free to the
>     pending-unregister callback, as before;
>   - on an application thread wait for a running callback with
>     rte_intr_callback_unregister_sync() so the device stays valid until
>     it returns, then free.
> 
> memif_intr_handler() no longer disconnects a device that has already
> dropped this channel: it stops polling the fd and returns, letting the
> waiting application thread free the channel. Once memif_cc_detach()
> returns the handler cannot run for the device, so the queue and region
> teardown no longer needs cc_lock.

It seems the teardown is too much complex.
We can probably make something simpler with a re-design.
I'm not sure about applying this big fix on top of a fragile design.
I'm aware it may be a big task.
Tell us if you think the teardown can be better fixed easily.

Otherwise I suggest disabling the memif autotest
from the fast tests series which runs in CI.
What do you think?


