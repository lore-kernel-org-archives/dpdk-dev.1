Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3832C44515
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:10:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0D3540653;
	Fri, 17 Jul 2026 19:10:20 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id 9F3A340297
 for <dev@dpdk.org>; Fri, 17 Jul 2026 19:10:18 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-6611669cd16so4800262d50.0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784308218; x=1784913018;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AsgY2URPaUjsT1ppxs2sKluJkEYz9Cqq78yCPNX8VX0=;
 b=Utw2lt4TInNeEJmy+f/iyg7QYMC7mf052u09REFxkVxLCm9QQV9Rmeug75MpTV9PaH
 TYLvbqcvPq2l4el+4tyLTU0OtqKIBFLNNTzslrgcIdD0V0tISTwEJHsOVltdP9j4L1a+
 2/IY/GZ4gAc99BCp5HBXcrzPlVp/XEu6PpeKZdzf+I4iOrl0d2iwwokTHKtYY3pRq82h
 mOM6beTMgqazm7DrQlqq250ZNQoZM0tcVX4B2saTp5PilMbrW5qSWtQEG3ghLmO0u58K
 pl1ME7J821YxK1iaC2Zbcx0wG9ARIVsvT+1zY4w8CAg4zPY+AsxtL0SgHK3T8kuKDWqZ
 R98g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJjyBDymShF0NruRtvCyet4UcVCThCJ0FPCSRVEjrXFEEL66hirBGSDk0i9NvEzKclY+0=@dpdk.org
X-Gm-Message-State: AOJu0Yzvki3RvPpcNrZdp6/YODWC0I86pBdImFooWsT4RppP2eTXyxjK
 GB+yVzBFZQPjCGwe3EzNWMrqLNlnxDtPITbwf+w1hbT+eq3tMLKAovCgCA0EUN9saT137XY5N3o
 illxKlmQApVEMik8E4UW1ut/ACW+ijTPRPBVhM6rxY5jm2qbuvVFuPL4Bdrw9MtRwbWArVcUz6p
 E6nzG4A9lqZID6cZSCPlPMQTmKgrNaZ9vf75AqVDriyat7hq7hZKoS5nATP8De2+lOJpU3cipgC
 SJpxA==
X-Gm-Gg: AfdE7cmC/S4hzAaRo9zaoVw5nmfupAPp8Pr2r/pHs0hl1euTTLyCFvbFqIybX5y0XY/
 u/Y4pRm1UlRCwosx3sySqS9zyv7Ny1aJIoPT5gy8/R0H09rx/sbMCwXf2+7UZOVnKyOTJ24tyt4
 QkZ7CzBwWx5Gf/pQwUe8hHRIC0B0O+1PSv2ptZe8rZhIJaUu2SuQ1N9fDVlnzqmp8PHrtkxKy/S
 zjcGzW3JFIDhWi5gKfytDNQkNQa8jBTlya9AdfWqpaXBPsmKykfUPYC8bTPATXPp1gRWvWkJ/qP
 UeonS5Uz+eNk678vxRKHQcVj3b6fqqY5ufQbOhx0jeP34x0Gp7bO54DwcBJzBlWvzMxyis/PG7e
 cpj6BuS4IooJ4gjRH5L53EomLX4EAs40rdoTYekRA6gjEjJWVuoqmJINuPActYuzY/TMIt8rl8K
 P2aA+vNyuzP1mwlWCoWXyfj/+BngpL6NbGSEf2xi0lKgViiA==
X-Received: by 2002:a05:690e:2458:b0:664:c10f:c593 with SMTP id
 956f58d0204a3-6683bb5e30bmr758013d50.19.1784308217623; 
 Fri, 17 Jul 2026 10:10:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-6683b548bd8sm155422d50.10.2026.07.17.10.10.17
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jul 2026 10:10:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493b0a5e636so73481955e9.3
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784308216; x=1784913016; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:thread-index
 :mime-version:in-reply-to:references:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AsgY2URPaUjsT1ppxs2sKluJkEYz9Cqq78yCPNX8VX0=;
 b=TAlxpRMoC3YUYLgamnMK5qAwVkuoovmm4SXJZdmMb5JyX6pEKjAufsq8hzSd8fYEwC
 b71aEKS4CBBTfC2EKczNAL+OrNcIDQ7QS5oFUbSmiHAk56SrrNSoPyUpp7v/cJZbjFH7
 yosxvnqPO5u4s88n5PEIXThBjxt8doTk7T79Y=
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/q57nG2Gjp4b9x/gyXGcfhuZFaQGPt5qsYzEnZDAjr+YLcfS8jxRMYJVQqouULMlBnmE=@dpdk.org
X-Received: by 2002:a05:600c:630d:b0:493:f261:d295 with SMTP id
 5b1f17b1804b1-4954a3d6565mr39778125e9.4.1784308216043; 
 Fri, 17 Jul 2026 10:10:16 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:493:f261:d295 with SMTP id
 5b1f17b1804b1-4954a3d6565mr39777805e9.4.1784308215628; Fri, 17 Jul 2026
 10:10:15 -0700 (PDT)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGqbBAvmviBHaImE9znIl3FBco5NgG/wjvAAUXytrQCcCoVxQIHlwrFAosSo1u2hwELEA==
Date: Fri, 17 Jul 2026 13:10:11 -0400
X-Gm-Features: AUfX_mwLi38SubqR0jmJQrXICI6q0yNWoQSPemu38hKDzHLkc4RjM_p9hmj2X4M
Message-ID: <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
Subject: RE: mempool cache change
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 fengchengwen <fengchengwen@huawei.com>, Thomas Monjalon <thomas@monjalon.net>,
 dev@dpdk.org, Wisam Jaddo <wisamm@nvidia.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000006879f60656d1a13b"
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

--0000000000006879f60656d1a13b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

The below patch works fine for us. We tested all the different packet sizes=
.
Thanks for the patch. Do you want to push this patch since it is not
changing the ABI/API?

Rgds,
Kishore

-----Original Message-----
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Thursday, July 16, 2026 5:57 AM
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: Morten Br=C3=B8rup <mb@smartsharesystems.com>; fengchengwen
<fengchengwen@huawei.com>; Thomas Monjalon <thomas@monjalon.net>;
dev@dpdk.org; Wisam Jaddo <wisamm@nvidia.com>
Subject: Re: mempool cache change

On Wed, Jul 15, 2026 at 11:12:59AM -0400, Kishore Padmanabha wrote:
>    On Wed, Jul 15, 2026 at 5:02=E2=80=AFAM Morten Br=C3=B8rup
>    <[1]mb@smartsharesystems.com> wrote:
>
>      > From: fengchengwen [mailto:[2]fengchengwen@huawei.com]
>      > Sent: Wednesday, 15 July 2026 10.12
>      >
>      > On 7/15/2026 4:08 AM, Morten Br=C3=B8rup wrote:
>      > > Hi Kishore,
>      > >
>      > > For your testing purposes, please follow the guidance provided
>      to
>      > Wisam Jaddo:
>      > >
>      >
>      [3]https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F65964
>      @smart
>      > [4]server.smartshare.dk/
>      >
>      > We need to recompile in this case. We should try to avoid
>      > recompilation.
>      > I think it is necessary to adjust RTE_MEMPOOL_CACHE_MAX_SIZE to
>      768 as
>      > a default configuration.
>      Changing RTE_MEMPOOL_CACHE_MAX_SIZE breaks both the API and the ABI;
>      so it has to be done when building locally, where API/ABI breakage
>      is acceptable.
>      For DPDK 26.11, where API/ABI breakage is acceptable, we can discuss
>      increasing the default from 512 to a higher value. I do have some
>      input to that discussion, but let's postpone it until after DPDK
>      26.07 has been released.
>
>    We should increase this value to avoid performance degradation, as
>    users may not realize they need to change it.  We do not have do it
>    right away for 26.07 release but we should it right after the
>    release.
>

Out of interest, does adjusting the 50% fill/flush threshold to be a 75%
one, i.e. fill to 75% rather than 50%, flush to 25% rather than 50%, help a=
t
all? Draft patch below, can you test it quickly, perhaps?

/Bruce

diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h index
50d958c7c6..2526a23903 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1417,6 +1417,7 @@ rte_mempool_do_generic_put(struct rte_mempool *mp,
void * const *obj_table,
                           unsigned int n, struct rte_mempool_cache *cache)
{
        void **cache_objs;
+       uint32_t quarter, flush;

        /* No cache provided? */
        if (unlikely(cache =3D=3D NULL))
@@ -1426,30 +1427,39 @@ rte_mempool_do_generic_put(struct rte_mempool *mp,
void * const *obj_table,
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);

+       /* A quarter (25%) of the cache size, computed with a shift to avoi=
d
+        * a divide. Draining the cache down to this level on overflow
leaves
+        * room for a burst of up to (size - quarter), i.e. three quarters
+        * (75%), of the cache size.
+        */
+       quarter =3D cache->size >> 2;
+
        __rte_assume(cache->size <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
-       __rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+       __rte_assume(quarter <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
        __rte_assume(cache->len <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
        __rte_assume(cache->len <=3D cache->size);
        if (likely(cache->len + n <=3D cache->size)) {
                /* Sufficient room in the cache for the objects. */
                cache_objs =3D &cache->objs[cache->len];
                cache->len +=3D n;
-       } else if (n <=3D cache->size / 2) {
+       } else if (n <=3D cache->size - quarter) {
                /*
                 * The number of objects is within the cache bounce buffer
limit,
                 * but - as detected by the comparison above - the cache ha=
s
                 * insufficient room for them.
                 * Flush the cache to the backend to make room for the
objects;
-                * flush (size / 2) objects from the bottom of the cache,
where
-                * objects are less hot, and move down the remaining
objects, which
-                * are more hot, from the upper half of the cache.
+                * flush objects from the bottom of the cache, where object=
s
are
+                * less hot, draining it down to a quarter (25%) of its
size, and
+                * move down the remaining quarter of objects, which are
more hot,
+                * from the upper part of the cache.
                 */
-               __rte_assume(cache->len > cache->size / 2);
-               rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0],
cache->size / 2);
-               rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
-                               sizeof(void *) * (cache->len - cache->size =
/
2));
-               cache_objs =3D &cache->objs[cache->len - cache->size / 2];
-               cache->len =3D cache->len - cache->size / 2 + n;
+               __rte_assume(cache->len > quarter);
+               flush =3D cache->len - quarter;
+               rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], flush);
+               rte_memcpy(&cache->objs[0], &cache->objs[flush],
+                               sizeof(void *) * quarter);
+               cache_objs =3D &cache->objs[quarter];
+               cache->len =3D quarter + n;
        } else {
                /* The request itself is too big for the cache. */
                goto driver_enqueue_stats_incremented; @@ -1557,6 +1567,7 @=
@
rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
        int ret;
        unsigned int remaining;
        uint32_t index, len;
+       uint32_t quarter, fill;
        void **cache_objs;

        /* No cache provided? */
@@ -1592,13 +1603,23 @@ rte_mempool_do_generic_get(struct rte_mempool *mp,
void **obj_table,
        for (index =3D 0; index < len; index++)
                *obj_table++ =3D *--cache_objs;

+       /* A quarter (25%) of the cache size, computed with a shift to avoi=
d
+        * a divide; 'fill' is the complementary three quarters (75%), whic=
h
+        * is the amount fetched from the backend to fill the cache up to
75%,
+        * and also the burst limit for this bounce buffer (since the cache
+        * was just fully drained above, up to 'fill' objects can be filled
+        * and handed back to the caller in one go).
+        */
+       quarter =3D cache->size >> 2;
+       fill =3D cache->size - quarter;
+
        /* Dequeue below would exceed the cache bounce buffer limit? */
-       __rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-       if (unlikely(remaining > cache->size / 2))
+       __rte_assume(fill <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
+       if (unlikely(remaining > fill))
                goto driver_dequeue;

-       /* Fill the cache from the backend; fetch (size / 2) objects. */
-       ret =3D rte_mempool_ops_dequeue_bulk(mp, cache->objs, cache->size /
2);
+       /* Fill the cache from the backend, up to 75% of its size. */
+       ret =3D rte_mempool_ops_dequeue_bulk(mp, cache->objs, fill);
        if (unlikely(ret < 0)) {
                /*
                 * We are buffer constrained, and not able to fetch all
that.
@@ -1612,11 +1633,10 @@ rte_mempool_do_generic_get(struct rte_mempool *mp,
void **obj_table,
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
        RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);

-       __rte_assume(cache->size / 2 <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-       __rte_assume(remaining <=3D RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-       __rte_assume(remaining <=3D cache->size / 2);
-       cache_objs =3D &cache->objs[cache->size / 2];
-       cache->len =3D cache->size / 2 - remaining;
+       __rte_assume(fill <=3D RTE_MEMPOOL_CACHE_MAX_SIZE);
+       __rte_assume(remaining <=3D fill);
+       cache_objs =3D &cache->objs[fill];
+       cache->len =3D fill - remaining;
        for (index =3D 0; index < remaining; index++)
                *obj_table++ =3D *--cache_objs;

--0000000000006879f60656d1a13b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCC3QSkUfqkej4bgkpDgNmiviho3osLUEDUGsXuqeThqAjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA3MTcxNzEwMTZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCzT3Gh7Io2
c6YdEeYbNtnfwhh8irD1+c7Knn3Vn7yKec87TnARxS7+6lvZk04rUL1BlTSL1EgOTF2DgRdssqG1
hb66KFJlBPmyTjj3L0lACoJEahQssJM1cUdvryeYtHJkaY0vyEBSHutjPop2r5yoJyIaJnj728K1
HrO9dXtoRw7pZTYgjutsAGnf9CGBscL0Pkqasr76tjuZYZpDY5QlEkgC9dPLpaZFD/PI+4wut1Q6
CSs6e7CkB2oBDiKW2s8MShqss2CUFXDydBEr108JyYzsQmOwxuLmO9qMyqaJvfVxHZadwLTnC+rR
kIgQNa518HKRfOlABJHWA4PbTd25
--0000000000006879f60656d1a13b--
