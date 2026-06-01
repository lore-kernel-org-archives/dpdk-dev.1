Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A2CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 14:21:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98DE24025F;
	Mon,  1 Jun 2026 16:21:28 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 1FB244025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 16:21:28 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 6F7261D00497;
 Mon,  1 Jun 2026 10:21:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 01 Jun 2026 10:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780323687;
 x=1780410087; bh=dBLIxCzpXQ6+s23hZBEVLf/MryTLn00AtZljjgcp7Ns=; b=
 gKCkf9395bYagTT9yesQ42xJZzq+tGB83p5/U5bRhZtBxLf1XM1vLXQ6gxjxlCx6
 bAvNAZEHVVU9Him6ogdiIUW5oL6xHCEOCarQneHkn7YX18nExlsN3CDlhWUFb8s4
 m+JeeBeCyjE+Ve2qrKj2jtSxX1tnVP7lFeiSh5ojDAYdeoBfAytURylG17LTwTWu
 FThnbLwQTWhWMuMKicyjA0xi0XPhHFH9jvEMJ6MYVAlx4BWoMWfFISRWHvW4QlRb
 zNQTppt0ioBgNtgS/C3/eZvdrA7eXAksPni0IuV2J53AtdySMJwRqEcGKAYzNz5X
 y7zY2QlxfNfhbKARJWzt2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780323687; x=
 1780410087; bh=dBLIxCzpXQ6+s23hZBEVLf/MryTLn00AtZljjgcp7Ns=; b=j
 w/SBlr7slq1RcqeEF2Q0+gJ42WHLJfA6RaJ3RZFn3y8WkkQrT+Lajy1VjCu4fkvr
 Dc9gYYOHaBqN2SSubfuudrowodNrAFJuUbyhckE0mdhrZBqjCIZHNhet5uX4HlJA
 0JrDp+myw8uaFKYX9AAKL85mZqXjKj1RF+qR201aVyTOMz7q4E+qvEGerMgWE3e6
 1tG4kPJ+FTb1U4ZmtJBZ+W36CprQXiJXEfD8z1O7O4NaiZ4yYSrjlaztDD7SG9PJ
 HcVl+5RMQAZL2AOztRMJK7j0nLoyMN+o4NzgXodr65bd7CNAxouSKMlJLueQGI2X
 AetDTzivK9oUxcZsMOTyg==
X-ME-Sender: <xms:Z5Udai96DjOcz5HggxA7CRjtOESmZOQdHO4-ENlQrgYTlA0QfwPUxw>
 <xme:Z5Udai3B1S4RRZWpLe8vhp3xrkMmmh0znCpyqasDcx-RNNNrLRPtAl6q8Wkh_Zxm2
 -iO50SXZ1dVNrmlRicl6IVHnWUbiTHw0XNII-6jXXB8pqJzdPGf>
X-ME-Received: <xmr:Z5Udav-34IVUljQUzY28KCMFn5iXYlf8_YJEPSk9nb6r9NLhqou6JqSOmENaypGZbOqCs1r_FXxk0li4_QZjQjBxew>
X-ME-Proxy-Cause: dmFkZTGUWkhS5eTdtB3mW5FLnh2t2XqK/00lsGwIXgczb2nH1D0LVETHaapkKIm0xJQOmW
 glNk5IyRbJKAkRjrrih1+P98MireJA/5/dsKxeH3fwgiyHoaetXvSGLXfac21nB/CT4b/K
 E08/TW8vsNh48d0R0e10r7x90irOY4A2NgriDL1CMlT8vBZjI0eKjeq3xlNfx56GvsHDPt
 lvyf4eohD2duf+l2VuTU1VKrEr//IUGkJuqGTyW5aRLn9TV/zUufBEd9Fe2fTiud6Jb9rk
 kf1lnkI34NZsyKbnZAYDar08q7FGAn01D4t2H/XIYEOKjA1Hs6QYTkdEeBR4kMfuDxeTJ6
 8UdqF+At371BvQ080kG86xTfHEokDHifw1ebBSU8ujXBoM/tZfblqFTmDxdVWwsuGqFf0b
 5gdgvBhnCzKh9sntrsZb6W0G0nER8vfwKj1NsBx2AXQa+eqktO8mbJlREZqg/dZAHMJwqy
 Yz3F75jJALfybJMeLUpfHIUbSccB9pwEz1mcK1hpah8Xd2B4fzqnnqnC3aw8BqIfTTtf0M
 HI5SM3z5yuIvVG6rHeI55rwXR33CeZ6gaiRgbPL9tja4Gf0ZQV5FE4A113x50nPdKfYpsI
 Cyy/0SfkhUBxxYxwmq7F/slu2qCNGUaCOARqCfTYtZPfGfeGAHptuFqGwOdg
X-ME-Proxy: <xmx:Z5UdaisyQAoBKKqGMj3tZB3wwTqiTX9TVXz2ibCLK6NhpUgf08P47g>
 <xmx:Z5UdaiAM9gGSSpkJSCwp3BTiXMzKXtszfzhAsTD_FPmQphwcZ_rUQw>
 <xmx:Z5UdaqX3R6t16y3xtMqX11CPGDr38-99hJPKMNtPIsWnCtcdgUe2UQ>
 <xmx:Z5UdagDlf6VD1nO1dvmW4Dj1QAu9A0Dwk-zjcVvnPA9XxPRby89TOg>
 <xmx:Z5UdapXINaPqC6ZJy6cgew2Qugsy2tqvE0-_3WwY4Nj_yFxzwyZpm4fH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:21:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] devtools: add Vertex AI to review scripts
Date: Mon, 01 Jun 2026 16:21:25 +0200
Message-ID: <bUYoD1-ARAaefqQHkOtV4Q@monjalon.net>
In-Reply-To: <20260601132402.1125588-1-david.marchand@redhat.com>
References: <20260601132402.1125588-1-david.marchand@redhat.com>
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

01/06/2026 15:24, David Marchand:
> +    if args.auth == "auto":
> +        auth_method = detect_auth_method(args.provider)
> +    else:
> +        auth_method = args.auth
> +
> +    if auth_method == "vertex":
> +        if not VERTEX_AI_AVAILABLE:
> +            error("Vertex AI support requires 'google-auth' library. Install with: pip install google-auth")
> +        auth = "vertex"
> +    else:
> +        api_key = os.environ.get(config["env_var"])
> +        if not api_key:
> +            error(f"{config['env_var']} environment variable not set")
> +        auth = f"direct:{api_key}"

Could we have such code in the common file?



