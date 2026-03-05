Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1202F47CBA
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 19:29:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDDFC402CC;
	Thu,  5 Mar 2026 20:29:53 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 9F6F64029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 20:29:52 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12732165d1eso9277535c88.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 11:29:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772738991; cv=none;
 d=google.com; s=arc-20240605;
 b=DB+AOpijtifL/1QfbTWj/1JlNuhLUaPSkML2crGdX4MqPmhUpmccLDr0cWLP1Z7PbB
 K4YmDHlokkDjK40094IWKXWeyKmXsXZMeJhyU+6MLGGQ1s1KXV3c07p99nPmiPmfXSET
 ZhJkvzor/NgVVRi4mVlZtVlY6NUvHj8Q5ZOPQGJv1hxALBJAeX52AEi9cBct2dJYsJf2
 VFbgbarggt1JszimKFdKo901QSxStu57/jc02ZilVx+mCzfjstg/LptrOMvcNfXUqUic
 41eZ63ueW2vqSeoxXVAhTXclJMfM+4mAd0QgLEkGEqthT+P7sny4Pg9Eg/JouyyFAyca
 sZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bullda/xMgwXnyaQqoSxt2WkgUTJKYBlvP/uKrJqbpw=;
 fh=4W2N8S/7y4PInWzrAs0ECbgUPDsi7aK/UjA6yz/I58c=;
 b=iU88QV/xbZpHFuScrE9F3hunpWAVepOjWB7hHpTWWCUl6fIKCVw5HnSc0tCIGF9Ewe
 1VLNVqZaAN5t+kqe/ZZaqqzyoWiJeaP+S/JhL2u5IDe0C1YiamM7HwGCSVxTsuQ5pygY
 /UXIRf97sGZZb0Q9EjhT287ksrwVmvFrhIJhzyus7H9BoD5B5oOhmbqkV52fmNKdX/Zf
 M/ZGsN3S3Cm9ZbBsc4GmIaoNxMzJ0F9x6FrFE+EzGBSB+X0AABHJGox4G+G6h/WAM2NJ
 DkI8+481Ur2YvUZ425fKD2CeL/7Kz+vh5OstcB9/m6Uu98ke8t6EPdgjEdv8eF+TkpOy
 W/Iw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772738991; x=1773343791; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bullda/xMgwXnyaQqoSxt2WkgUTJKYBlvP/uKrJqbpw=;
 b=RTbi60tTBjafmaCs17aZrKUDq5OrfkxbuEbeyL6BzcziVg9JFsedWdBUub83ac90ux
 PWA5f4JlrQaPtsvGO5nZV1d3bQ+yqB/BAQFyrL8lnYUDf0KDe4N+niXfAtLAPfaAQgbl
 yGTXwF7fKVBHM+CCpKPo5cNi2zQokyshqr7+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772738991; x=1773343791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bullda/xMgwXnyaQqoSxt2WkgUTJKYBlvP/uKrJqbpw=;
 b=dkmHa7chfq2zivHtu6kTd6eC/oG36om5+XNmNS0m77lPKGSgS4V/5UE2SADTzJk9bG
 vw54xmeakmi/kWTaPFO5oHDl93RHX9KEWlC0409ZTWt2EsCiMfeFcnhQbbB5u8RwiCZ8
 3URiKreyK0TiDNFLF5vcuBzJ+926/BCIm7h4oI1QnxGbrH5R5y+P43pmWiDJkyzSYujR
 KrtWPdpXDjl+DrKUFDxLlBCxB9QJYi3tquJFwduplja2p1OmE5HH6L71LKl39oopkkpX
 5W2cI5rmX23daGHgJKZJsup81KFdpusgsEw9wBgJ2YXfXsQoNVH4ZDdnGyGmChaZvwyC
 GWOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwciQaOJE7urgkjzeNnhVYtOZwiCIMcueVV1LHbpIqdL8+35CglJJGhbLuZ7fU4AdRIB0=@dpdk.org
X-Gm-Message-State: AOJu0Yz0TQscu2b5IsLPHzDPgslBWwK/2oIL+hFVaGVqlPH6cvZX8Kfu
 H8lUPYhikCFu7eWd1NNNV6osL/Oz7Z/IJL33d9ngXJ2NxL7rPqbO5NzGrr58LvtoHmMO7Sd1i+g
 MhkH3MSjlkM3I740hgT1mTvxFqRNc4RYuVoxLu/wXFQ==
X-Gm-Gg: ATEYQzxhdvhgf6jx4Efi7MGhQ/01rWWkXngRFv3KpxNvCd9FELKyD31M5TCZR5VYgSa
 HUyaAzQQjgBg2Rie6k+w3F3U3u8IeFQIszE/3M1MWb468fMOdYK7kOdxBza6D5sVF7NxIiWDOOw
 KRiel6I0AKNwTk5SSRIYyfnnsoWmSllPDp5yHEoJvFyYjouJbFuViTlGdg+pgFr5l0AfN73afbj
 NNVvnRtGxdW1oh3WTAF3ha21J6hjHzONb/fG8muJH0eXfLBxujE5cbj+CNH5KuvfGUn7v4gC02j
 RRV1IMDN4DcsBJlGPIjFnLXn17w2vgH1mEBlfbzDwpD2x3QEbBMSZqusvRsC4P+PIjulETUZ
X-Received: by 2002:a05:7022:1288:b0:128:bae0:e036 with SMTP id
 a92af1059eb24-128c1164913mr456565c88.27.1772738991502; Thu, 05 Mar 2026
 11:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260302185438.122584-1-abailey@iol.unh.edu>
 <20260302185438.122584-5-abailey@iol.unh.edu>
In-Reply-To: <20260302185438.122584-5-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 5 Mar 2026 14:26:53 -0500
X-Gm-Features: AaiRm52AIN4uQVzVmkW462QdGWLjv6Wu04EtPL2IdEQZxORLfVjurF2eCrl0ixs
Message-ID: <CAJvnSUDQ=j4Z0nTceFBExnhNK66nnCgfM_8oi1kPUgpPnZpgew@mail.gmail.com>
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
>
> +config_list: list[dict[str, int | float | str]] =3D [
> +    {"buff_size": 64, "Gbps": 1.00},
> +    {"buff_size": 512, "Gbps": 1.00},
> +    {"buff_size": 2048, "Gbps": 1.00},

Either Gbps needs to become gbps or the gbps field from
tests_config.example.yaml needs to be updated.

> +]
> +
> +TOTAL_OPS =3D 10_000_000
> +
> +
> +class Config(BaseConfig):
> +    """Performance test metrics.
> +
> +    Attributes:
> +        delta_tolerance: The allowed tolerance below a given baseline.
> +        throughput_test_parameters: The test parameters to use in the te=
st suite.
> +    """
> +
> +    delta_tolerance: float =3D 0.05
> +
> +    throughput_test_parameters: dict[str, list[dict[str, int | float | s=
tr]]] =3D {
> +        "aes_cbc": config_list,
> +        "aes_cbc_sha1": config_list,
> +        "aes_cbc_sha2": config_list,
> +        "aes_cbc_sha2_digest_16": config_list,
> +        "aead_aes_gcm": config_list,
> +        "aes_docsisbpi": config_list,
> +        "sha1_hmac": config_list,
> +        "snow3g_uea2_snow3g_uia2": config_list,
> +        "zuc_eea3_zuc_eia3": config_list,
> +        "kasumi_f8_kasumi_f9": config_list,
> +        "open_ssl_vdev": config_list,
> +        "aesni_mb_vdev": config_list,
> +        "aesni_gcm_vdev": config_list,
> +        "kasumi_vdev": config_list,
> +        "zuc_vdev": config_list,
> +        "snow3g_vdev": config_list,
> +    }
> +
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
> +            str(get_ctx().sut_node.crypto_device_type)
> +        )
> +        self.buffer_sizes =3D {}
> +
> +        for k, v in self.throughput_test_parameters.items():
> +            self.buffer_sizes[k] =3D ListWrapper([int(run["buff_size"]) =
for run in v])
> +
> +    def _print_stats(self, test_vals: list[dict[str, int | float | str]]=
) -> None:
> +        element_len =3D len("Delta Tolerance")
> +        border_len =3D (element_len + 1) * (len(test_vals[0]))
> +
> +        print(f"{'Throughput Results'.center(border_len)}\n{'=3D' * bord=
er_len}")
> +        for k, v in test_vals[0].items():
> +            print(f"|{k.title():<{element_len}}", end=3D"")
> +        print(f"|\n{'=3D'*border_len}")
> +
> +        for test_val in test_vals:
> +            for k, v in test_val.items():
> +                print(f"|{v:<{element_len}}", end=3D"")
> +            print(f"|\n{'=3D'*border_len}")
> +
> +    def _verify_throughput(
> +        self,
> +        results: list[CryptodevResults],
> +        key: str,
> +    ) -> list[dict[str, int | float | str]]:
> +        result_list: list[dict[str, int | float | str]] =3D []
> +
> +        for result in results:
> +            # get the corresponding baseline for the current buffer size
> +            parameters: dict[str, int | float | str] =3D list(
> +                filter(
> +                    lambda x: x["buff_size"] =3D=3D result.buffer_size,
> +                    self.throughput_test_parameters[key],
> +                )
> +            )[0]
> +            test_result =3D True
> +            expected_gbps =3D parameters["Gbps"]

Gbps <-> gbps misalignment with tests_config.example.yaml
