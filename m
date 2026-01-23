Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8016D77880
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D13B940269;
	Fri, 23 Jan 2026 17:46:38 +0100 (CET)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7A48F4021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:46:37 +0100 (CET)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-78c66bdf675so23228107b3.2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:46:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769186797; cv=none;
 d=google.com; s=arc-20240605;
 b=jmzMvfv19ltY1RuqHDMweG0ggGBSvAcyhUNAJDiyI49u/xwl0UOQ2CqvjgrTEywXzf
 k4F+LNyOhibyfdtxCyEPEsbQzBpNkH9d90NqA9cMhJ3XNZhvB05UFbfWev+NoVl2L9Rc
 D5YdhdzWctlv4mlf/yFdo8Upo3LdWDnTmvzdXGwf3cfCeuSXdcFyJkVLmuaMCkVgvUll
 xgyqhh6dECmfzF5031VttQcnWU/tlyI7CU08gpm6rNorXWVuQJqjRcBJWNkzKzZreQAy
 7LGzqVaK8p3AHlp9upzSqyRoFtXIzyjsosRFYdtPA967OW7ganc0iLVUNQFo+VaRPPIx
 XE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XE97ZZoefiY7OZ6gf01cZxdrll1lYAo3X+D4b4bKNUk=;
 fh=H8dAKSwJHGW6eAHCLmKbQcZhGWygM/zA2abO1LhT/FU=;
 b=UDW7wWQqB23qRPjfh5qQhrGCyF4KGTs9eIxlqlugN3Yq7W+UQ6HBOV4jaMLgAoDfjJ
 Vo2xxm9Ry0eLUm94FKzLywx7Yz3fttA+8WyvmEnlwtvOy83+dTWT4siLNSeMs24KkJis
 pVA3B+wmvkvEfVu8Ur1He9OoldyxJ/ocIedKOCxOyVupKg+qGfdEIOlGPSRtJrPjY4PF
 CLIKwv/VbXoCm8Ni9aLbmFTtmPiIsuoogUmfnCRbvs+g9FjhXyLVnYptG1jnOnvWZsss
 pGQHNZQsrYY4GCdVpFWu2VehWfyEx5BroCk0HY7J1NbxvwDDrpIsSxzYdccN/Fc7PXYb
 gw7w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769186797; x=1769791597; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XE97ZZoefiY7OZ6gf01cZxdrll1lYAo3X+D4b4bKNUk=;
 b=NFUYcWpcp0jaS8lUZffC2KHKj2L1drvrZDWfgTDzITK1qVtYkmQ7fz2mk6H4UWeMM7
 GwBmi5l8ppFlKaK0QYTeyNMIIHhI3TDtC9NuCkzSp0KBmrNyr6wHi6vVdK049Zgy6vT/
 CmLupdPyilIKavrcc7Nb3jvGOoRl7gJlvxCyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769186797; x=1769791597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XE97ZZoefiY7OZ6gf01cZxdrll1lYAo3X+D4b4bKNUk=;
 b=dVTefTtNIHc9g1YkibB2QdD/9trXdm4KKaw3DgH0j3QQNVU2MEwzMm8lePRJiarZmo
 764jZ+WB6zHdBnXjbW6Vbr//V9Xqb00oJF0TB4W9sAn2JoNaTlAAmClTBG4YkzYfuXDF
 C9X8V75Fq8OlrtCf9yV/J9huT7YQzMoczf5zzXBbCLG6IOyVbqKTaY6km9lORlLugwkR
 BDjvJC097vEkSqS2/hwVcDGohiKPVkvykli/Ctbyyv7IFKIXU4Mhcjh6+a1yTLql2a+d
 +lN55IzwftAeQcqD51qbq51BYlKQoNzK0LFJ9WI/pWEmMMpMwvnuqos7yEjxBtyXnAZD
 h7zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXysK8NNZ19bYUrRknzeWUB45bbEYa7OUb0XE/ZHTJ6kMRvc4rWbPpaaf60QKgl/ct0eGM=@dpdk.org
X-Gm-Message-State: AOJu0YyfBmvNBj/Ss8Vc/XlxLZ8dL/wcolgOZf1tOQ1H83p2Ogazm65L
 6ucQ2k3J1xLvCkrTrimh/l87zOLE/sR9L/tPMXTKnLSUje1FWpuNdzO6lQ/pYWgR/5MW0yW4/8B
 Wheal6AV3zP5UegkAvQhFY4YMnvlX2SkaY5MFL9KbmA==
X-Gm-Gg: AZuq6aKG5zf2Yg367AuFiSZsME6j/ubl1d1BkHyfZtXucZeEiDETPmPHZA0Nv5j8d3z
 l+zuOTwgoKOdklk0/7j11USdRoOCcdAuI0tKlyl0WjRFPCLfEb8MqzmyWCT+AvAZdeUbtBCLOZW
 wKox8QEaAEhNsvmM1AnYNqyO7Rz5WPshQ9Rzr+K//tRbiUZsdO5a88cZndtY8omeE+pgFL67vJ4
 BFqWNL4Kfw/hbC4w6spbaCs57io6m5jGA+ZuZ+Oe/LMY1dTMWyp1YCcZLP7X5TSMEHRy9OapzXz
 qRb/VWa7+OvkWC1VMkhI
X-Received: by 2002:a05:690c:6709:b0:793:b460:f07a with SMTP id
 00721157ae682-794399aa412mr26427687b3.39.1769186795302; Fri, 23 Jan 2026
 08:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260122214424.322422-4-abailey@iol.unh.edu>
In-Reply-To: <20260122214424.322422-4-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 23 Jan 2026 11:46:22 -0500
X-Gm-Features: AZwV_QjIdfUF5i4MQtuo_rQ83TUxqnUfkGOxstx1HxSl6P28Uz_8d2D1G5BF59M
Message-ID: <CABD7UXOj5zDHc8e8L+7qCxjAL1zEun4hRPvbuOdnRTKGTfbCgw@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] dts: add cryptodev throughput test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, probb@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com
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

On Thu, Jan 22, 2026 at 4:44=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Add cryptodev performance test suite. This test covers throughput
> performance metrics of various crypto devices using the
> dpdk-test-crypto-perf application. The results of this application will
> be compared against user supplied performance metrics and fail if signs
> of regression are apparent.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
<snip>

> +class Config(BaseConfig):
> +    """Performance test metrics."""
> +
> +    common_params: dict[str, int | float] =3D {
> +        "Gbps Delta": 0.05,
> +    }
> +    throughput_test_parameters: list[dict[str, int | float | str]] =3D [
> +        {
> +            **common_params,
> +            "buff_size": 64,
> +            "mops": 9.85,
> +            "gbps": 2.49,
> +        },
> +        {
> +            **common_params,
> +            "buff_size": 128,
> +            "mops": 4.83,
> +            "gbps": 4.95,
> +        },
> +        {
> +            **common_params,
> +            "buff_size": 256,
> +            "mops": 4.77,
> +            "gbps": 9.76,
> +        },
> +        {
> +            **common_params,
> +            "buff_size": 512,
> +            "mops": 4.52,
> +            "gbps": 18.52,
> +        },
> +        {
> +            **common_params,
> +            "buff_size": 1048,
> +            "mops": 3.77,
> +            "gbps": 30.87,
> +        },
> +        {
> +            **common_params,
> +            "buff_size": 2048,
> +            "mops": 2.49,
> +            "gbps": 40.86,
> +        },
> +    ]

Would it be worth creating a separate cryptodev config file in the
configurations directory, or adding a cryptodev section to the
tests_config.yaml file (similar to the single_core_forward_perf
suite)? I feel like this would be more consistent with the current
design of DTS, although if there's a good reason for the config class
being in the suite then disregard this.

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
