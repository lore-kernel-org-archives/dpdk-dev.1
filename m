Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC600CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 13:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC252402A3;
	Tue, 26 Aug 2025 15:41:56 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 9F1264021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 15:41:55 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3c51f015a1cso2759182f8f.1
 for <dev@dpdk.org>; Tue, 26 Aug 2025 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756215715;
 x=1756820515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8i5r5lnn4itcX/F8TTsx+bM+TJpXzWo7OKEZn9sWybI=;
 b=orwOHPB1aRM8904OszMLvn00gF2MMb8VHw4+xp3o/M7QiKnrUm67bbgwk+UfUZ9B60
 wU7ihIhxKP/QMPdD86ZFVJQU+G3+m8eqE7yav1pqOxHBN2/Cl82Sxl/eTfcmrHOeCxxd
 zChfdJPsn4oMNRDAUNjA5U3yv5SohehFYVYpJRPE6GNg93wYpVT3maaD6BgkjDML7kmp
 PdbvR3HLb2Qp0augvlnNXfCppmVU351g+G6qcHgEpw1Uv8S9+wudkBWEXTnyIFUgwm6T
 J5fQiKjAEak+kpNVf+DxD2lGFDS4d3hPOo+fEl/MFGRsE3jfPo1wHRVULkhClYAgCdvG
 5kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756215715; x=1756820515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8i5r5lnn4itcX/F8TTsx+bM+TJpXzWo7OKEZn9sWybI=;
 b=vIBy21K2gocGBBT9gHSOAalZsFwhyxQe4HdGuNsXd2qvQ11sw85Mt+M5Npe6Ndbpr7
 4rbsJRjkBkmAUIO0vyc5Xu/NUQeOlIOjK2qhnRYRgKCg6K4jnFqudCbWsaP3A4F3c5LA
 pd3zI+jhr1rda8eDvD7dr2rH9nqMdoOL3B7SHib4gqNGPQxSWu8E5ArcNyO0OMxyMrTg
 YFWONbcSbJY6/nPIw9UlnBB2Kj56i+sd24yjhrv96E/Z6Yx2Fm2Ds93i81kXrjRPg6ff
 cIYUIaJXO8vBbXa+uzn5t8+qjVTwFYnD0ECfC+cxp+LB5dSoW7kS8D5uZEk0qxp8hdXT
 FtDw==
X-Gm-Message-State: AOJu0YzjTjLoVHmuiQBaF/80aa1xceIHgbR+ofD/mCXrCldBtVLoqRqz
 CtaJkcMqiewgATvmaKLAs+hcgNDuta94HknZOVIJsWxJAxMsO236IISQmQdHB/TCe2s=
X-Gm-Gg: ASbGncu01f8kIAWvNx9w9mqYkw7Rmv/XwF8yzUhseI1GGZYlFr7ovPRAbqKc0L8QXI/
 hdSG3bVkjXP42K+2wCcvst6WLs2eC6Q5gkCgmeJUIPiSf9DOhZHxH0UrsZJwlLZ5dx3qFZgkGgx
 XShs2bA2UVrUdm5Xl3LgY/5g6w6JsF4N50fHIjctPKoVESg8MftwZdX8sHb6Zihpnq0Q39steHC
 k9dxTMtcHwg6HP3qBRYBNBKxSqLboAY8j1sF8J25XJHeguH03IeuL6Zf65hvZwjP2iCE2R7L3IV
 PFQtg0V+1nBrs6GxZd3JrEI7trwLQZjWQry/KGuXvaPePk8p2G9VYKMH2tXN53ydLl80MhnRQB/
 hSUoueOro7CeS67GmA/z0Eohn+WEf+J1L7dsmnpb1IBPKApQ3TvdRuIkc/GKqGeW/9vTHolbFpQ
 4=
X-Google-Smtp-Source: AGHT+IGm6wADaCJFpbY5b3HsBrP6wlo2X3Ukrdwu7pn9y+Mzy617/4KLopF4mASGzPdyW2nFxAMTiw==
X-Received: by 2002:a05:6000:288a:b0:3b9:1109:7064 with SMTP id
 ffacd0b85a97d-3c5daefc5ffmr12464504f8f.15.1756215715173; 
 Tue, 26 Aug 2025 06:41:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c9c9324dc9sm7895442f8f.3.2025.08.26.06.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 06:41:54 -0700 (PDT)
Date: Tue, 26 Aug 2025 06:41:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>, "Sameh Gobriel"
 <sameh.gobriel@intel.com>, "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, Mattias
 =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v2 3/4] hash: reduce architecture special cases
Message-ID: <20250826064149.25787722@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE6C@smartserver.smartshare.dk>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-4-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE6C@smartserver.smartshare.dk>
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

On Tue, 26 Aug 2025 08:55:23 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > +static int
> > +rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
> > +{
> > +	return rte_hash_k32_cmp_eq(key1, key2, key_len) | =20
>=20
> Is the "|" instead of "||", to compare in blocks of 64 bytes instead of 3=
2, intentional?

The cost of the conditional branch is usually higher than the cost of doing
a few more instructions on cached data.
