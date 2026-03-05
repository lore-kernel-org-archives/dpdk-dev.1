Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95BF3D332
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:47:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ACA84275B;
	Thu,  5 Mar 2026 17:46:48 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 7098641611
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:46:47 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso308640c88.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 08:46:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729206; cv=none;
 d=google.com; s=arc-20240605;
 b=RlyfKmZtuz2hEWIccfSnA6QUe16QFgXvLjpw0Zmh7LIPzbmHTHAh4gPaz1gBh6Rg8t
 tFkTQvxXxrFSE6zLMuEtasBUqXbjVSvY6ieH1wom72WzbLkQtnv2/grR7WFjJVIqLbIr
 ovvwYqTteE/6OcgdfYx7eTGpw5sTpQ4fuI4gu7kalEOXDh4s+TV8YI27UmrQTIOIF0jf
 iTBzy3HXbPumJa5zkRa2IofKeZfbB5AeY06x9g5RjrfucH/upWegzyJ0hKyWY2LKQWdu
 S2LQ14PxTG0hr83EAetlnhZnmnYEfU1Qkv4ykqE1ep7/R1h1PL6e8dTtK4G34HhLsEkm
 ZISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YiVt6CXaTWMdL6Z43Dhfv7P3Ux2W8CTmRbyH9v5v6IA=;
 fh=25SdM/CB6s478YHw6js0MDhEv9N6K/9s9niqLU264Uk=;
 b=iGkieJzkJNeeivrjcuOiqlScck8zwwIB4AYTJlI9aDv2ailXmZ5L/Lf+hMURK1KDO/
 IX2As2YYH7JHtCEdBg/piIYSO2SwNRLKLvVXOZulwGcS7bt0VSUF/ddQKkPLE+KTHNNi
 UH8zYdSQQCCEadb7L9er8Oy8qd0zQd54k7VefQb1Xnwr2WUN1+6oN7hFiFgLp7OHNCSu
 gCUViYkXz3Zwpvm0TYFiTF1gseyt5aXfOXs6MQ5fkeuZjT7569CQhBkoxitsR6657Fkk
 SuoJdr/HgRtlj6yRNqB4pqWziL5UpF953uDsJnrJt92UVCyZYr8J8RyYCQe4ZZcjvqdK
 lInw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772729206; x=1773334006; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiVt6CXaTWMdL6Z43Dhfv7P3Ux2W8CTmRbyH9v5v6IA=;
 b=AVzFAnYLNj3FbBM3zcdgad4gNgHaaG3ESZK3MVGB9ZR+URlVHFkjamnRIWBGv3zCZs
 TcH3yzC/rzEO7f71xPsyvID2wmVQpmA+NMXbcmJ3tDY9pcnmTJg8hEqvLyb1muflXRim
 EkbWmI1MtWOtYOhGyRvgJLN+VZK9tU97QtzbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729206; x=1773334006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YiVt6CXaTWMdL6Z43Dhfv7P3Ux2W8CTmRbyH9v5v6IA=;
 b=r/xYprZaA1PV9mKw+X/L/JjmVpCxlEZ5hPzianU1hip055TZOTfJgQlCmtch1i+Db/
 PdhgUpVimkpaohRCQ1Fhaw5DSr0Mlk9bhGL1pnPCbogI75DCrKz4hGTtFhauuL9EREg3
 AhHd0NqtdPepaO9AcRa57AusGRV3I1LW0Ets+3PGlLtsrSXUQdYTL6hII5NEK/jkm59y
 1J4hpIIjbqNnQSqnR8naljeNcScBSM8B8p/PDcb6h3MiejmJfBS0ETBgucN0VzORPZIF
 54BJhdhuKrQIID+OpndBgsBUZJRu07oY8u1PmiC7nvBpxkqySsH3Olp62DFdHSTiab8w
 Jk1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs4XHUW/Q/B3uJWM3FAGzSMcmbM8vcwBBLqtHMLRu9Dpclx/K5Qab8fYfvY+RfU25dkIA=@dpdk.org
X-Gm-Message-State: AOJu0Yyqcj9ExIaBMmKt3NiMeFGvDyKeQ3Hl1ZfJD8n2u/7ZHh9Wu8bl
 FetRR4dwbvUevSBoNOJz7UwRENstyKplZEFXsRfokuSaE26PWXPVHmfTCQZQoJBpxW6t8YziY4W
 1KU5pjTaiWId9ws5j5BNXIy1GBx4Ht7AZJnTksaXSZQ==
X-Gm-Gg: ATEYQzw0XZng5WXetu15YM/rR9Pt+adN4aH7ldDTlpQmcvYvtFhoEAuuIwADl9c/17B
 v2Co0PpHXJmWgN1nKFqYzeuAXwpFH06kZFKu8l8jt7WX1Mzw1nTriJlTDNucXFHEvTQE0/IsugB
 F1LseoIBukQtSvaT+mIHaApHQm+TCwWjFAdPFDsaa98DZBXLbeYl5HZlFFyqbUOpSdqGty2oKSg
 R1dOkU42rTlTA+1xkPqK2xki5dWpiwhM1/5M+blv18pTudpb08fVOws6DzmA8shdkvagT5BAMHL
 O5c5wuxrBa441sRckJQ5KgGplqoNLUOU5eZeHLtDy07VfNuhXCXuZcOcJBAqIVea7gN2iVMN
X-Received: by 2002:a05:7022:525:b0:122:345:a948 with SMTP id
 a92af1059eb24-128b70fdee7mr3353165c88.46.1772729206315; Thu, 05 Mar 2026
 08:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20260106213803.205934-1-dmarx@iol.unh.edu>
 <20260227192016.495703-1-dmarx@iol.unh.edu>
In-Reply-To: <20260227192016.495703-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 5 Mar 2026 11:43:49 -0500
X-Gm-Features: AaiRm50qi3jROlz68JMk79Ibk_Th-8IGGsBMnmy5fN1YI3svXS_0hMOqDuqoJ9c
Message-ID: <CAJvnSUB00qRvEORQi9GYhca6i_Li7gsNgQ0S1PZ1HDumBeUzSw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: refactor flow suite with generator pattern
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
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

On Fri, Feb 27, 2026 at 2:20=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:
>
> +@dataclass
> +class FlowTest:
> +    """A complete flow test ready for execution."""
> +
> +    flow_rule: FlowRule
> +    packet: Packet
> +    verification_type: str
> +    verification_params: dict[str, Any]
> +    description: str =3D ""
> +
> +
> +@dataclass
> +class FlowTestResult:
> +    """Result of a single test case execution."""
> +
> +    description: str
> +    passed: bool
> +    failure_reason: str =3D ""
> +    flow_rule_pattern: str =3D ""
> +    skipped: bool =3D False
> +    sent_packet: Packet | None =3D None
> +
> +
> +@dataclass
> +class ModifyTestCase:

Don't just rename FlowTestCase to FlowTest - also drop Case from this
class, and JumpTestCase etc.
