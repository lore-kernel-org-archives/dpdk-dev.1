Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD8606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=I9NBY/5q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=19kq6NAy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8931402B2;
	Wed, 25 Nov 2026 12:19:03 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTPS id 484DE4027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:19:02 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 418FD1400444
 for <dev@dpdk.org>; Wed, 25 Nov 2026 06:19:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 25 Nov 2026 06:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795605541;
 x=1795691941; bh=8FYi0IoSgd3G/RH8EwT60WtH9K4Cjajq8gaIAvKeUX4=; b=
 I9NBY/5qAqhlpck5gJU6xMfqqL0jl3oKhVfVDLoEeN81LuvPJc2bTgLMRwXtyyp4
 fxrT2uF65B5+63/PNFH1EQeELM3TBIJ/LhcCN1qhZ7dYpeJMe3IYvdAQYfsmnYww
 iZff0O+KKkgvDwXiVre9tTjHKV1jM0dSwSOzOSAh0KEJiCqk0u/B60VORButwlUa
 B9JAMNPrzCjRPjM50IlOWmwvRiS7I58VdwBejknCNhmzbVIK0bwguVSHngqyHpQ7
 AafevTRMKoMk/8KPSmPjfpYcqXYtuxS17Yk2RTS6zax/1yP+aeOmcd5lxGjavpiR
 z4gHn2PKUSFohCEE0N964g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795605541; x=
 1795691941; bh=8FYi0IoSgd3G/RH8EwT60WtH9K4Cjajq8gaIAvKeUX4=; b=1
 9kq6NAyOL3e3ZI84Ev+B+saF7ud764ljCQiTosEX2WhOS5YHuHCwSBpNMJ4uyJQL
 7+iT88ovEeb1KSGvHrtbb/Cba19BvtK3gslHZClkgYiADCJUYpmfStBH23zOyiEh
 QhpXcGRA5i+RyBjJB3tBJU8En0kAuiNLaSjm4TD1DlAkvRjX0VC2jHjZOQinHP11
 ffLLfFdTYHclbMWhLUJADle/+4TYFmpVKk2c3qC8imdBAW4/s+gzwwAC0Mi/xcnS
 GQv2jsklYUxJU6G+9EKyuusej550uSxnbxCtkVy4FdVqBpNJdf8hmmjaVrwnr2Nf
 rqFPFOoed8fOxzPtGOqTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795605541; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:aZlpneQochvQ9CqrERG1HReZ45D2PqOYOESJmnG1nvpZRed
 1iYoTUkSza84UWn8G3kNYict0X/+dIGYiIIBODJuCZVXrSyYinK/hYMGfQfVKm2o
 /vz14f0r7vdjgLLpgYJTCsITY610Y9IrT/euDSyG2457KsFl1cR6TsbsUz83Wpkn
 mHji+YD7WaRbquxTOKK4omW8kvlm/DQ7M9HCZ1cczLUGkXl2SJQqUhBfJlliV05t
 1gPFAMUj3wFsBo3P16Rsx+iN9HAjrBb+GTCEuCpcIXpwuVhcT9sq1xrUPQosIocg
 Ur/kqOpjOTdTe3xvmrmpDsCVsBkSaQi72KL803A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:r7BK018LgA88gXjPvskiNFt//1JyuwPU3/FB04Wi8Xs=:nlCuXKyjCmJuVfziItqQSgiTTZqXHEuvoBXTdqr3dLI=;
X-ME-Sender: <xms:JMQGa1F8FYTU5NFVcTAGIzerlRmh1l6gQCLEzPY5Z5SRsIMq_KT8zA>
 <xme:JMQGa2qhLSWdT2IyQ3v4XrAmrgrZU2XoWfCRJ35RHwK-BUpcVbWfSmh0EFfGLngsO
 Ydmj8OrzvM9bcXW_vQvfu3iexDlWfsvN3qTYKy2pu4Sa1LZr_HatQ>
X-ME-Received: <xmr:JMQGa57_KZyWhsJxwHsdvEWW2akl09um1MnTuJe6Wov8qnQCnV4xZJE4UBCN0-ikUKF0kk_Z0ySaY9Qx3OnCq5E>
X-ME-Proxy-Cause: dmFkZTGsle1/rNRHc8vtYGBlzqT0iolaVVUI0v+IY82g0Kz0UwpqVWMWDYh9dv/6HP6QK/
 EP+me8XV/sdEMeFy+V/4nE/1CwSQIBvtjHHj3rM/nQ1BVScwfRLfsuv0IuirysfVauzsE/
 NyvFJ+UdVtyR1619au7O935EtPCJyjjdppRrwcFkhTsciE1OsgGrlpNxExU7DzOUl4x3dH
 ulyGLxjk/dFUqo/sfRMXni/OMG/80GRhmKh9AiJ3lBExunssYKN4ouK+nONUJE2ZpbHo92
 LK9MErkzRWdUspM1URdBilc8jweYv5ABQ0zbBTSswvlQtoD7Ty2a8KBS8sr/3+/2wHuadu
 viSiWvVclP+jRN4IgDj9mB5BsDxtekAxUqjnmJo4VZrb3GXN0vNte2lGBbgoecg8ABKvdd
 p4JeFoem9L6zjmjU+AC02mi6pts7x5eJV4uyH3FESXCV62TpfhidJVwOhfrrGk18XizctI
 j3+HohVR7F/HBiglybZfUW/It5iYYWgLcqIW1CHh/g56WChER0/xSydvjhPc4DObCxMX0k
 WcY4ujO/F+dKYXIo551fa294u53zZtLvRoApCy/TY3wy8dyaZ5RJo2R5TX3tkVx6lePN1B
 dhYbnp2LLL5qwcdEjdIhBa0I0Wv0NQddCo7yHp/YzE9la+e271lfth4RJ5LA
X-ME-Proxy: <xmx:JMQGa85pxbsXTAaOVJcj94GxgETWZD-uWKH8S5928Ux6aa5NIrzqcQ>
 <xmx:JMQGa-EWTrIrstLllcurwoqcRxI0VASKOspd25TouyjgfDJ_IQq_XA>
 <xmx:JMQGa9QsFHGizo0xVJL20U3aKTVISAtO1CoKpUAeANtVvwNP_y6Xew>
 <xmx:JMQGa_sLFFveGmYENbXAKoJTUlbRnOHbokRPC2OZMLsXvIeW3TMMSg>
 <xmx:JcQGa9n4ukwlPJIhGriqyVEuBgcviQSwG-3p2N-YtpHwZzJjfBn1puPc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:19:00 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: document that fork is not supported after EAL init
Date: Wed, 25 Nov 2026 12:18:59 +0100
Message-ID: <tRHmK-wGRvSfdfy-XxmTYA@monjalon.net>
In-Reply-To: <20261123182202.340811-1-stephen@networkplumber.org>
References: <20261123182202.340811-1-stephen@networkplumber.org>
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

23/11/2026 19:21, Stephen Hemminger:
> +    A child created by ``fork()`` after ``rte_eal_init()`` must not use the DPDK.
> +    Calling ``exec()`` in the child, or making no DPDK calls at all, is safe.

It would be safe if we didn't have atexit(unlink_sockets)
in lib/telemetry/telemetry.c


