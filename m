Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311CDCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 16:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC354064E;
	Wed, 27 Aug 2025 18:05:11 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 5F3ED4029E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 18:05:10 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so2520156f8f.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756310710;
 x=1756915510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEYaTKka0GgDbxqKpusAkjSGfSdhE40AttuYMerJzdo=;
 b=0YA4vGToPzpaVZFcwRs/dr0Big76QYh55kQ6R99fwUcCjZiSZ1rH0Wz9UAaT6rJ5CK
 hRF5okVOoM1rGz4xYwu9g4nuaZLoeL/iqrqNSTkAvi5yeltpz1D5/8+RLdnf9aVUhDos
 I8m3qPRZmjxjFEegEYgShc8t10v2o/XiPKYb2gkugI/aIPdk16Fe0j/EqW/+MQqQf0RG
 vckB0PHZSmZgqyNRes3GGh69FscrjtQFLbRfVoQ2WbFdyUK6qaAfJWeCX9KeOn7s5QbN
 Tam7EgUMMfqULPgDwihoJLE4Z0zFHZqXdXJzSA6MwyD/w3W6A/kFVcQru7XOCVBsZV37
 HmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756310710; x=1756915510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEYaTKka0GgDbxqKpusAkjSGfSdhE40AttuYMerJzdo=;
 b=sirgMhjQxolYlfBgE2ZZR/z2Qpam+MNhGNZxxQ3jff34O/rjeIwVCs/u5L5OcqY6X9
 lBQapU17dPWz0lMoy+WS99eludffNa++bpcFBF7pEwUsW4tfTzp9d/U8qH17Tedj8VX3
 UxmQ0AU+3UKpHVUzGF7Qy6zrv3u/lZKpZpGH7YFnFr5VHlNnfCZPL96Pk0Pl/saVYPrm
 tKvLKeLMoTE5rECmZh/TtcoMgkGCbq+oEVgYhwcviJwffrW/DDiYvU8MKnmB7Haft9Ho
 IRsTSwtb2NFw33LGZImlgmnoSW0Ja8+6UA9ktnK437oIw1Z/vTtWae44AOq4bMGf/HoG
 BpTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlTyRJzsRx2XCSHNhaQoskc+Lm5S0aXFk0RlgmVKtOZrb65aalLyZKctOWtdnt8IND0CI=@dpdk.org
X-Gm-Message-State: AOJu0YySYVSejNWBtmSlhrfqb6tfBrXX8TU7rrB/yeIIeTaufD27uQv3
 bNRPBdHysV7y+NqXydhM8X7y1djC4e62v6s+z9yb9QanXDadUqndq9sQC8wenYJaeaE=
X-Gm-Gg: ASbGncuWsBk7gh2na5ObyKJYbwa/k6IL8DnpWd6p8uXzzMz7CClyAW6G+GFcvE+RrLD
 438SjTmppJp11CU4WSxudoFMShEFWqY92XcUgIZH6qptouuxBT3ska1qBQhpGTinpTiiP7bmQAG
 KAP18uVQPIf4XEhAguLSdakHxZiNCJ0kpqP4OJ0+Wi2ND5+Bj5VA8Fd5kgF6QUiK+EZtHpgQ9dR
 yB6IiVbITmDpctdyYGCqttCUmfk0H4e8qMp5MjGxeKV8yQbi0I9t8QoFYf0LgIG6y6RNb8/pHfR
 aLcLGwLFSVQZYjmc5KSBe6xUGfHWgy0ijEpGgIf1h3kjSdBjUh2v+9l7A/3kU20yXrHJx7Dv+du
 FsT8OW0OkzwJkMq6ACgc5JaIXW9XfY2BlTRIQXmOc6oJC78RkUyGRYmw/aWXrrY2IR5vc2jXEZG
 +snZyke5E62Q==
X-Google-Smtp-Source: AGHT+IFLvxbAIOAmPE3AR+dQqw9HEqb7rPQ33mG+5WtMXmqHvWl/FTG5ffyqDEzYoZC25B14cefSYw==
X-Received: by 2002:a05:6000:2586:b0:3b7:8146:4640 with SMTP id
 ffacd0b85a97d-3c5de34953emr13745045f8f.56.1756310709670; 
 Wed, 27 Aug 2025 09:05:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd0acafd09sm2443537f8f.31.2025.08.27.09.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:05:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:05:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>, Aman Singh
 <aman.deep.singh@intel.com>, Sunil Kumar Kori <skori@marvell.com>,
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: validate dscp and vlan table entries
 for meter creation
Message-ID: <20250827090504.7ae3b66a@hermes.local>
In-Reply-To: <20250827111837.3882892-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250822121430.2228507-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250827111837.3882892-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 27 Aug 2025 07:18:37 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> =20
> +static int
> +validate_input_color_table_entries(char *str)
> +{
> +	char *token =3D strtok_r(str, PARSE_DELIMITER, &str);
> +	for (int i =3D 0; token !=3D NULL; i++) {
> +		if (i > ((MAX_DSCP_TABLE_ENTRIES + MAX_VLAN_TABLE_ENTRIES) - 1))
> +			return -1;
> +		token =3D strtok_r(str, PARSE_DELIMITER, &str);
> +	}
> +	return 0;
> +}

The loop doesn't look right, it is looking form next deliminator at
the start of the list? Normally strtok_r is used with a different pointer
as the "saveptr".

=46rom man page.

       The  strtok_r()  function  is  a  reentrant  version of strtok().  T=
he saveptr argument is a
       pointer to a char * variable that is used internally by strtok_r() i=
n order to maintain con=E2=80=90
       text between successive calls that parse the same string.

       On the first call to strtok_r(), str should point to the string to b=
e parsed, and the  value
       of  *saveptr  is  ignored  (but see VERSIONS).  In subsequent calls,=
 str should be NULL, and
       saveptr (and the buffer that it points to) should be unchanged since=
 the previous call.
