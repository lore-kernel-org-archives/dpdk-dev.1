Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602FAF47CCC
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 20:23:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57AC0402D8;
	Thu,  5 Mar 2026 21:23:37 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id DB005402CC
 for <dev@dpdk.org>; Thu,  5 Mar 2026 21:23:35 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12713e56abdso5287447c88.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 12:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772742214; cv=none;
 d=google.com; s=arc-20240605;
 b=DzPBEB7IxgtX+/ACvnA3/EwwHSIYNiWNBvdARCnmncEDTGvHbCyJXBZTMq5aeih/6G
 0fITvKEZ7a2NyAKNzfyrgIYnvQAw1VRFiQFcoW/xN01uz6HyVHyb+1DmRpDEiYn7NusM
 nxgzcFuKq22Zh4Q3NTOI9oFM0XoFDwEb2OQWnT18TRPxvvdF1WNy49ukjonuIYrpPjfF
 eFYhCx5hoF8+SAl4jtVITqn/9sJwndO6XXFdTPc9Tyz1Oqy7y8DIY6fUlJoxwb15Ftrc
 18dWSWPNAYMPgzjrtvS+WsMi3Pzs/gsgs/+CmyF+lQDPPSJtlY1IE0aM7G7oq7hzVVtG
 4scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PDnwpQusS/LGrPQhOG6hspyyDegGyir3Xx54y9tui8s=;
 fh=r+3SmE9z5ab2/g5J785nlLHo014NmIyeesCS+yYUR38=;
 b=Mjt6sf9ZJm/wkIbw2VjcIZCzymXYNrJHdQxa6jbWq7w+M9CqXDRuJBAXcz2wBBNDkv
 mKO2oAcv7XDU5uqBLWGAmTUbSVJbwxDrXC9hE02fsQZeOixjltKimhfvClkmEuOwkWFA
 77rX5SEat4sen44nyzEffDtS3Z0Rzxgigt2ZXJS605uMVHOnusvy6Py/Al41n4m4eoEM
 BoD8m1ApkuV/rFYYZp8oXPiUgaShKBlQf488tmzI3QdCxfccWKkDQ2PShpTvyY3BHASR
 sdMmpcsxu8ufbYQesdFZTwzWxAJFE6PxUA9dfehpJGo2MUT2MjkkyOn1Z2y4O1/SQoHd
 Nr4Q==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772742214; x=1773347014; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDnwpQusS/LGrPQhOG6hspyyDegGyir3Xx54y9tui8s=;
 b=ZzoN4IFqmGR/qjqOhJ8WKDjpbpiChFBgm2nnYzmscZRhVRiZNeuNCTgFdMacaWpAd4
 g6QBIW8c2yNZf32UxOqLi2POJakHhfeAbT/SqSMln9Ywxs82JSpJxjYDjF1IqGz6e6+P
 yco8vkzVy7b1Hm3HnXNGoioKrwryPFjFhZc+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772742214; x=1773347014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PDnwpQusS/LGrPQhOG6hspyyDegGyir3Xx54y9tui8s=;
 b=lSvb4AqasAmZbbFic34HmOj4TQ3o2HPBRd0ZOFRlKiK6uEeuRWGT/9tkFywRwIEvjE
 5XLLSH9M/BM66Rc0hZFjaR33fsbG9+diuaB9I3jWeSec+AyyXyAhN/qQc1oOtqV6q0fQ
 6ky8Lht1eVWz87UipmAmoH8YhiOswI/pgB7LnNgrj6GH9ebVkf47sIT1GjBvwHEXgy0m
 6a1Tfv+cZEHH5wP9zjdIwCVsnKNspe0YSM+hZB7HgKyROVfMYzte60hWG3loAujnuOlA
 wuhrWtSZwDNPbtb2miC+Sesn9TLeLKlNTt4y1QJNIN2WiiOdzHozClYyR9cnRegtdokD
 okFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYLwdzxkpcbfccccVtV/P0TrglcyHzlzCYI0iX1utgEbQNzGCb1dz6t95iLzfKPjoU8eU=@dpdk.org
X-Gm-Message-State: AOJu0Yyz4oSyBkIXqlhQTe8Ls37MsSkGs7AFbPYkvZTLHsCA5CLCxuxQ
 vRaeawdZD4WOII5vwn1T7xYCFjHNIqMwqcjuA1zV0ChpM/w4n49rprYDnxgYxD74h4En5PInaGK
 YsGkQpOs0JG+9KlS7LswQ2U4ZveGnRqIfT7AZiSgaMA==
X-Gm-Gg: ATEYQzzIuaG8UJ+uK4OLAznQKWgnht+WAiwmYPQo8on0mFzKUBG7BjuWOsRSElzGDmq
 36/aE2BIwQcw5o6RDem/lmAwswxpsrii5+Jbk5TX2kpWEl+KVqtZhokV+/tF/Zl8DwyAm3BcCGc
 zDtLOhawvXgR7FNYOrEystT5o/0oN8dS5ttXt+SJ5K06quRYordPXzQKbCKt5BuBuHGIiPt6gLM
 E/JGL9XB8Eg4j3F7EcLazix8upW+l8ffyLgdqDw5CFUKZkJpRpbVu8Er3f2NE4nbn4OJPWCKEn7
 6zJn7Zn8YTHTORonCHuG7ZJeSVqZDk00qCM+0th9Ls8L1i3e/wjZxFONmwgZyGnlu3TMzPD5
X-Received: by 2002:a05:7022:e982:b0:128:bae0:89b7 with SMTP id
 a92af1059eb24-128bbfa3cafmr1453434c88.3.1772742214394; Thu, 05 Mar 2026
 12:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260302185438.122584-1-abailey@iol.unh.edu>
 <20260302185438.122584-5-abailey@iol.unh.edu>
In-Reply-To: <20260302185438.122584-5-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 5 Mar 2026 15:20:37 -0500
X-Gm-Features: AaiRm52Qg7HfqNTllCNvJ72jGKvO0IYU0_4U8XCFbkXfblzeyzqdGenRr4Ln6cM
Message-ID: <CAJvnSUBteq4SU_hJOrkiD=n2emAaf66K=Gniaajs6w+0tg32eA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dts: add cryptodev throughput test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com,
 kai.ji@intel.com, dharmikjayesh@arm.com, david.marchand@redhat.com
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

On Mon, Mar 2, 2026 at 1:55=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu> =
wrote:
>
> +
> +@requires_link_topology(LinkTopology.NO_LINK)
> +class TestCryptodevThroughput(TestSuite):
> +    """DPDK Crypto Device Testing Suite."""
> +
> +    config: Config
> +
> +    def set_up_suite(self) -> None:
> +        """Set up the test suite."""
> +        self.throughput_test_parameters: dict[str, list[dict[str, int | =
float | str]]] =3D (
> +            self.config.throughput_test_parameters
> +        )
> +        self.delta_tolerance: float =3D self.config.delta_tolerance
> +        self.driver: DeviceType | None =3D get_device_from_str(

does it make sense to change this to self.device_type to keep the
naming aligned?
