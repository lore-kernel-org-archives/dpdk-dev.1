Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE82606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=xDlua7eu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Fv4sDTKt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474D442DFA;
	Thu, 12 Nov 2026 22:39:37 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTPS id ED5A242DA7
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:39:35 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0BF927A078D
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:39:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 16:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794519574;
 x=1794605974; bh=rO42uxb5Ymjs1HSi3VBeojLtjgwyLuDCXx4hLKpM5l4=; b=
 xDlua7eu5VB/8LSmXshoELMrJnvlrPZ3pgC3HN3GyggSM02xlcYGpQ5YBl7pXZGy
 srellpSQPd+SUmaky0s6IyaCT8wITBI5l8moRE794oaQWQbSe7pkJDUFEPPoKXbn
 d0RWnOTv9Zf8VqAnhRD62VmUfkK77Lwi/MUT3ZJmpGNq9dRtNL8CW321Gxdt4WE6
 Lk3hYgffDrMkV/YGVx+hMZl6nVkGDSWpq4DOBuPmTQPwbZlQDdDt15nW8HA6AEZ5
 T2p3Ra1FqoEPpn9yMxFPd8nhYfjBflKNCEAqtX/YY9k25IOKpwH5z9P+lXw2cNp9
 Yr5/mfdpV3WVu6XRqx/kRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794519574; x=
 1794605974; bh=rO42uxb5Ymjs1HSi3VBeojLtjgwyLuDCXx4hLKpM5l4=; b=F
 v4sDTKt/YKMRAdtlsW+4XJVkjD20RHO8/LBg9CpiEzgCrtS+OQ82IG4Tps/7x93D
 BtA4mVoK+8y7syaSy4xECUIZOVdJ7krHatW1REydMX8uzGlQMgPk++z15GXQt+Bs
 9JVmtciI8F5NpFXCE3mhkYhefZYhSm8YksxfN03uc2AeDYqNLBTfRvIe/R/D/6Hu
 jv8Yq7imu9/ngax7p2RBw5YAXB6RBsJXxpCzVgn0MA24StPwNqZFOTUiIsY151G0
 lL1EaCwB4DxGiP/+okjNfnHve1k/hC4+jiwuHxTm/VOVjAjiybtYtK4YIuz87w0O
 h3eIDZEPdDlfVIH5TdkLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794519574; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:ldzH6E9qX8MPESgG6D+R9U3PyVryWBSIpz0KrABvhLsMDDO
 0QQzBOz5iYIP4HUnNPgpMu7UkOeFnRy+nNDgNE36j4C+n0PuB7tXI/8wjWhs0nUj
 CLXUqvIW0wMYRGeWOltzad698JTJb4jPyLZcOvuqWm7jnwcTEoc+1W/UeVI5Ik1A
 NhnbPlCb43qmdXQ7pKIYwUWH8IJBjMh+v2SvUHqJfx0B39pla+pA42Xc9L62FW+K
 rQMeZ4x6i2Hoa2sdkqWs4KzQIr30TPU7sbm4tQbuTSJ6dKHUM3RsfAexa6nUNKtU
 QBPC1G/aM/ip+N+MMKz9B0G0sDaVclWfmd+2Kcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:oiSyzEv4ffitX90crVQ8JT2SLQKfUnDHkKtd5UTAgm0=:OdpoSJt/1UqP4p/hqom1DHTCSgxLdb4bwqA+49akv/I=;
X-ME-Sender: <xms:FTL2aue0SiacaHzjgjPNbjHP_YKdAB1Pv2s4RUrGmTc3WPX5P3Hy7g>
 <xme:FTL2aoUR3I2iML9Xcc6JNpEN80YuFKemF2RQzapMbIJa_YfRO8ZcTGt-04-A99Ywn
 fPLzjueWbVihGo-NBQk5fOhwpa44y7XQvhayAj2drO1lErLSKePpj0>
X-ME-Received: <xmr:FTL2anf93wgcR_9tBLRk5v0_bl2XxKWdNk_Y21UJIlgbE1LTc9WD9b9B-avWBE8k3_agirQteQUmx_tfBIDqosY>
X-ME-Proxy-Cause: dmFkZTEbvU436cHz7CubxkIN0FucjwKTiQAzhieHX7baRTNgeUqojstmaxLXOzVXTanISd
 iUbrgIYQUlm2fRwd1yzOnEatePH0V3zWH9svN5QOJyP8XZfDxZX6TJmnI9mEbs8CS3hgsx
 e14ZWt3Gn0McIwxprtKeOEnBmNwZGiCCBO4F/c1P//sik2CF1A+FimOygsgebJ8ltsCz5E
 jyZ5rHWdJ9YR2k7ztIKUKGc+wBzt7L8lb8kVRV14psOG1hs45CJ1jq9tz14YLChKMEYE/B
 HDnotcSq0y14m34d7JTD7t5+TFLQNiYE1Ewdw1Io8H6FXnhkoA/bxkGMFtRUHddHH9moa7
 R+Ph5cpv0oL7UE2Ewv4K6Zom6iMKtmJ2S6QG0BFNmODJm3M+aWMOOdvgmGL09PvQ1qu30Q
 39uKlNvPZtSX62zZXkaKsoD5uZ1LKpUQmm8W9Cg2uKtyYTBtgu4OE7raJ22YdyTAlFRqsK
 fuXh/lm3MBscBLuNaMDxOnvzI7edwDmfomWgGwU9pys24W7F9vg4AdCmu+A27BK5aJGbFE
 6hLiNYpzr3KoMXS+0t2JPwLHbeqLKr2/cGBFueS1Gkxh52lAVBpzeihWywLySlDWu30cV7
 sCK2eMZR8Z1xEMvhZcyHC4kj9vC69UC7luJ4Vsl+a7X8ECQzTZfwpmvFUWRg
X-ME-Proxy: <xmx:FTL2akOW-kPM19oIXCP6B-KQjBUyQ9KHsTIDMRcjrjPgW7OrJenh8g>
 <xmx:FTL2alg6YCI8kIVmlhAuZH64FjLRvPl5EBUpXRA7LsU2gd0m_d4a4Q>
 <xmx:FTL2an31ownag6Vtf42Ejo2LxhcR13g8yEu9C7MsRpJ4ddVvSaSosA>
 <xmx:FTL2avgJ28uLxuKKZ5RzKEkCd8AD6exe8PoSxrSq25h8aTrHoywblg>
 <xmx:FjL2alIQB0dg_ifMgiGnJSXDx8VzBle9kNmaJtmUtpI80n7VfPI7-8Ho>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:39:33 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrei-Niculae Petre <p31andrei@gmail.com>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] examples/l3fwd: sync cli options with documentation
Date: Thu, 12 Nov 2026 22:39:29 +0100
Message-ID: <Xt2OnYToTUabxdVNsyR63w@monjalon.net>
In-Reply-To: <20261109004913.72418-1-p31andrei@gmail.com>
References: <20261109004913.72418-1-p31andrei@gmail.com>
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

09/11/2026 01:49, Andrei-Niculae Petre:
> Synchronize options between print_usage() in main.c and the sample app
> guide documentation (l3_forward.rst).

Comments from AI:

- The parser explicitly rejects 10 and 100 Mbps,
  so these examples should be removed.

--relax-rx-offload masks unsupported offloads
but does not enable software validation on all forwarding paths.


